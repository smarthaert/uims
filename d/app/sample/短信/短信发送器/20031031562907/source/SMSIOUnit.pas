unit SMSIOUnit;

interface
  uses Classes;

function NetSendSMS(FLoginUser,FLoginPW,FSend,FRec,FContent:String):integer;STDCALL;
{
  返回：
     0；发送成功
     1: 无法连接服务器
     2: 手机错误
     3: 发送失败
     4: 其它
}
function NetRegister(FSJNum:String):integer;STDCALL;
{
  返回：
     0；注册成功
     1: 无法连接服务器
     2: 手机号码错误
     3: 注册失败
}


implementation

  function    NetSendSMS;         external 'SMSSend.DLL' name 'NetSendSMS';
  function    NetRegister;        external 'SMSSend.DLL' name 'NetRegister';
  
end.
