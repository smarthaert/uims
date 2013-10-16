unit Global;

interface
uses
  Buffer;

type
  //网关连接配置
  TGATECONFIG = packed record
    RemoteIp: string; //网关IP
    RemotePort: integer; //省网关端口
    ClientID: string; //登录账号
    ClientSecret: string; //登录密码
    Smgp_Tag: integer;

    {这段配置解决的是 重庆移动采用深讯网关 上下行各分端口的配置}
    cmppRemoteIp: string; // 重庆电信7890 第一个IP配置
    cmppRemotePort: integer; //省网关端口   重庆电信7910 第一个端口配置
    cmppRemotePort0: integer; // 重庆电信7910 第二个端口配置
    cmppClientId: string; //登录账号 解决多端口同一服务器登陆问题 一端口
    cmppClientSecret: string; //登录密码 解决多端口同一服务器登陆问题 一端口
    Cmpp_Tag: integer;

    SgipRemoteIp: string; //Sgip网关IP
    SgipRemotePort: integer; //Sgip网关端口
    SgipClientID: string; //Sgip登录账号
    SgipClientSecret: string; //Sgip登录密码
    Sgip_Tag: integer;

    SPNUM: string; //接入号
    Flux: integer; //流量控制
    MCSTART: integer; //话单开始大批量处理时间
    MCEND: integer; //本月话单结束发送时间，就是说，过了这个时间就不能再发送话单了
  end;

  //SP连接配置   (暂不用)
  TSMSCENTERCONFIG = packed record
    GateId: integer; //网关号
    Gatename: string; //网关号
    GateDesc: string; //网关描述
    Flux: integer; //流量控制
  end;

  //数据库连接配置
  TDbConcig = packed record
    Address: string; //数据库地址
    User: string; //数据库登录用户名
    Pass: string; //数据库密码
    TnsName: string; //库名
  end;

  //业务代码
  TServiceCode = packed record
    LogicId: Cardinal;
    LogicCode: array[0..9] of char;
    GateCode: array[0..9] of char;
  end;

  TProtocol = packed record
    GateCode: array[0..9] of char;
    MsgType: byte;
    GateFeeType: array[0..1] of char;
    gatefeecode: array[0..5] of char;
    GateMsgType: byte;
    GateFixFee: array[0..5] of char;
    RealFeeCode: Cardinal;
  end;
  //通用的缓冲
  TCOMMBuffer = record
    Buffer: array[0..1023] of char;
    BufferSize: integer;
  end;

  //将String复制到Char数组中，尾巴不会多个#0
procedure SetPChar(dest: PChar; const src: string; const destlen: Cardinal);
//将Char数组转换成16进制字符串
function CharToHex(cSrc: array of char): string;
//将16进制转换成Char数组
function HexToChar(sSrc: string; var cDst: array of char): string;
//将字符串中的#0转换成空格
procedure ConvertNull(cSrc: array of char; cSrcLen: integer; var cDst: array of char);
function DecodeWideString(Value: string): WideString;
function Ucs2ToGBK(msg_frm: integer; const InValue: string): string;
function UnicodeToString(var AString: string; AUnicode: PChar; ALenth: integer): integer;
function BIG5toGB(Value: string): string;
var
  GGATECONFIG: TGATECONFIG;
  GSMSCENTERCONFIG: TSMSCENTERCONFIG;
  GDBCONFIG: TDbConcig;

  ServiceCode: array of TServiceCode;
  Protocol: array of TProtocol;

  mobuffer: TMoBufferObj;
  mocmppbuffer: TMocmppBufferObj;
  moSgipbuffer: TMoSgipBufferObj;
  mtbuffer: TMtBufferObj;
  mtcmppbuffer: TMtcmppBufferObj;
  mtSgipbuffer: TMtSgipBufferObj;
  rptbuffer: TRptLogBufferObj;
  rptcmppbuffer: TRptLogcmppBufferObj;
  rptSgipbuffer: TRptLogSgipBufferObj;

implementation
uses
  SysUtils, StrUtils, Classes, Windows, IniFiles, Forms;
  
procedure SetPChar(dest: PChar; const src: string; const destlen: Cardinal);
var
  i: Cardinal;
begin
  i := length(src);
  if i = 0 then
    exit;

  if i <= destlen then
  begin
    for i := 0 to length(src) - 1 do
    begin
      dest[i] := src[i + 1];
    end;

    for i := length(src) to destlen - 1 do
    begin
      dest[i] := #0;
    end;
  end
  else
  begin
    for i := 0 to destlen - 1 do
    begin
      dest[i] := src[i + 1];
    end;
  end;
end;

function CharToHex(cSrc: array of char): string;
var
  temp: string;
  i, j: integer;
begin
  temp := '';
  for i := 0 to sizeof(cSrc) - 1 do
  begin
    Move(cSrc[i], j, 1);
    temp := temp + inttohex(j, 2);
  end;
  result := temp;
end;

function HexToChar(sSrc: string; var cDst: array of char): string;
var
  i: Cardinal;
  j: integer;
  temp: array[0..1] of char;
begin
  for j := 0 to (length(sSrc) div 2) - 1 do
  begin
    StrPCopy(temp, MidStr(sSrc, j * 2 + 1, 2));
    HexToBin(temp, @i, 1);
    Move(i, cDst[j], 1);
  end;
  result := cDst;
end;

//UBF-16的解码
function DecodeWideString(Value: string): WideString;
var
  i: integer;
  S: string;
begin
  S := '';
  for i := 1 to length(Value) do
    S := S + inttohex(Byte(Value[i]), 2);
  Value := S;
  result := '';
  for i := 0 to (length(Value) div 4) - 1 do
  begin
    result := result + WChar(StrToInt('$' + Value[i * 4 + 1] + Value[i * 4 + 2]) shl 8
      + StrToInt('$' + Value[i * 4 + 3] + Value[i * 4 + 4]));
  end;
end;

//ucs2编码 to string
function Ucs2ToGBK(msg_frm: integer; const InValue: string): string;
var
  i: integer;
  str0: string;
begin
  result := '';
  case msg_frm of
    //Ord 返回序数类的序数
    8:
      begin
        {for i := 1 to length(InValue) div 2 - 1 do
        begin
          //  str0:=WideChar(StrToInt('$' + inttohex(Ord(InValue[2 * i - 1]), 2)
            //  + inttohex(Ord(InValue[2 * i]), 2)));
          //if ord(invalue[2*i-1])*255+ord(invalue[2*i])>9999 then
          if StrToInt('$' + inttohex(Ord(InValue[2 * i - 1]), 2) + inttohex(Ord(InValue[2 * i]), 2)) >= 9999 then
            //if (ord(invalue[2*i-1])>128) and (ord(invalue[2*i])>128) then
          begin
            // if (str0<>'?') and (str0<>'%') and (str0<>'‰') and (str0<>'′') and (str0<>'‵')  then begin
             //if length(str0) mod 2 < 0 then begin
            result := result + WideChar(StrToInt('$' + inttohex(Ord(InValue[2 * i - 1]), 2)
              + inttohex(Ord(InValue[2 * i]), 2)));
          end else
          begin
            result := result + WideChar(StrToInt('$' + inttohex(Ord(InValue[2 * i]), 2)));
          end;
        end; }
        result := DecodeWideString(InValue);
      end;
    0:
      begin
        result := InValue;
      end;

    15:
      begin
        result := InValue;
      end;
  end;

end;


function UnicodeToString(var AString: string; AUnicode: PChar; ALenth: integer): integer;
{**********************************
功能：网络unicode转gb
AString,输出字符串
AUnicode：输入数组，接收到的直接传进来，不用高低互换了
ALenth：长度
***********************************}
var
  TmpBuf: array[1..1024] of char;
  TmpChar: char;
  TmpLen, i: integer;
begin
  try
    TmpLen := ALenth div 2;
    if ALenth > 0 then
    begin
      CopyMemory(@TmpBuf, AUnicode, ALenth);
      for i := 0 to TmpLen - 1 do
      begin
        TmpChar := (AUnicode + i * 2)^;
        (AUnicode + i * 2)^ := (AUnicode + i * 2 + 1)^;
        (AUnicode + i * 2 + 1)^ := TmpChar;
      end;
      TmpBuf[TmpLen * 2 + 1] := #0;
      TmpBuf[TmpLen * 2 + 2] := #0;
      AString := WideCharToString(pwidechar(AUnicode));
      result := TmpLen;
    end
    else
    begin
      result := 0;
    end;
  except
    AString := '\';
    result := 0;
  end;
end;

procedure ConvertNull(cSrc: array of char; cSrcLen: integer; var cDst: array of char);
var
  j: integer;
begin
  for j := 0 to cSrcLen - 1 do
  begin
    if cSrc[j] = #0 then
    begin
      cDst[j] := #32;
    end
    else if cSrc[j] = #39 then
    begin
      cDst[j] := '"';
    end
    else
    begin
      cDst[j] := cSrc[j];
    end;
  end;

  if Byte(cSrc[cSrcLen - 1]) > 128 then
  begin
    cDst[cSrcLen] := #32;
    cDst[cSrcLen + 1] := #32;
  end;
end;

function isBIG5(Value: string): Boolean;
begin
  if (length(Value) >= 2) then
  begin
    if (Value[1] < #161) then
      result := false
    else
      if ((Value[2] >= #64) and (Value[2] <= #126)) or ((Value[2] >= #161) and (Value[2] <= #254)) then
        result := true
      else
        result := false
  end
  else
    result := false
end;

function GBOffset(Value: string): integer;
begin
  if length(Value) >= 2 then
    result := (Ord(Value[1]) - 161) * 94 + (Ord(Value[2]) - 161)
      //    Result := (Ord(value[1]) - 129) * 190 + (Ord(value[2]) - 64) - Ord(Value[2]) div 128
  else
    result := -1;
end;

function BIG5Offset(Value: string): integer;
begin
  result := -1;
  if length(Value) >= 2 then
  begin
    if (Ord(Value[2]) >= 64) and (Ord(Value[2]) <= 126) then
      result := (Ord(Value[1]) - 161) * 157 + (Ord(Value[2]) - 64);
    if (Ord(Value[2]) >= 161) and (Ord(Value[2]) <= 254) then
      result := (Ord(Value[1]) - 161) * 157 + 63 + (Ord(Value[2]) - 161);
  end
end;

function WordToString(Value: Word): string;
begin
  result := Chr(Hi(Value)) + Chr(Lo(Value));
end;

function BIG5toGB(Value: string): string;
var
  leng, idx: integer;
  tmpStr: string[2];
  output: string;
  offset: integer;
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Language');
  try
    output := '';
    leng := length(Value);
    idx := 1;
    while idx <= leng do
    begin
      tmpStr := Value[idx] + Value[idx + 1];
      if isBIG5(tmpStr) then
      begin
        offset := BIG5Offset(tmpStr);
        if (offset >= 0) and (offset <= 13972) then
        begin
          output := output + WordToString(IniFile.ReadInteger('BIG5', 'BIG5Order[' + inttostr(offset) + ']', 0));
          inc(idx);
        end
        else
          output := output + Value[idx];
      end
      else
        output := output + Value[idx];

      inc(idx);
    end;
    result := output;
  finally
    IniFile.Free;
  end;
end;
end.

