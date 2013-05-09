{/**********************************************************************
* 源程序名称: futu_sdk_interface.h
* 软件著作权: 恒生电子股份有限公司
* 系统名称  : 06版本期货系统
* 模块名称  : 恒生期货周边接口
* 功能说明  : 周边通信接口定义
* 作    者  : xdx
* 开发日期  : 20110315
* 备    注  : 周边通信接口定义  
* 修改人员  ：
* 修改日期  ：
* 修改说明  ：20110315 创建
**********************************************************************/}
unit uFutuSdkInterface;

interface

uses
  Classes,uFutuDataTypes,uFutuMessageInterface;

type

  //前向定义
  IFuCallBack = class;

////////////////////////////////期货通信对象接口//////////////////////////////////////////
  IHsFutuComm = class(IHSKnown)
  public
	{/**
	 * 设置配置参数
	 *@param szSection 节点名
	 *@param szName    配置项
	 *@param szVal     配置值
	 *@return R_OK成功，其他失败
         [非线程安全]
        */}
	function SetConfig(const szSection:PChar;const szName:PChar;const szVal:PChar):Integer;virtual;stdcall;abstract;

	{/**
	 * 初始化接口,始化各种数据,并从登陆服务器上取得相应的信息
	 *@param lpCallback 异步回调对象,由用户继承对应的接口实现之,为NULL则表示不关心回调信息
	 *@param iTimeOut   超时时间,表示初始化超时时间,单位毫秒,-1表示无限期等待.
	 *@return R_OK表示成功,其他表示失败
         [线程安全]
	*/}
	function Init(lpCallback:IFuCallBack;iTimeOut:Integer=5000):Integer;virtual;stdcall;abstract;
	
	{/**
	 * 启动服务,建立各种应用的通信连接.当通信连接断开时,也可以调用此函数进行重新连接
	 *@param iType 要启动的服务类型.允许取值(或两者相加):SERVICE_TYPE_TRADE,SERVICE_TYPE_QUOTE
	 *@param iTimeout 启动服务超时
         [线程安全]
	*/}
	function Start(iType:Integer;iTimeOut:Integer=5000):Integer;virtual;stdcall;abstract;

	{/**
	 * 用户登录,在做具体的业务之前,需要先登陆以取得相关的认证身份信息
	 *@param szUserID   用户名,一般指资产账号
	 *@param szUserPass 用户密码
	 *@param reportFlag 用户是否需要UFT主推回报，1需要，0不需要
	 * *@param lpReserved 其他数据,V1版本必须设置为NULL
	 *@return ERR_OK表示请求成功(但此时并不表示已经登陆成功,需从异步回调中取应答消息)
         [线程安全]
	*/}
	function DoLogin(const szUserID:PChar;const szUserPass:PChar;const reportFlag:Integer;const lpReserved:Pointer = nil):Integer;virtual;stdcall;abstract;

 {/**luyj 20110701用输入的参数来接受回馈信息。不需要异步回调。修改单20110623004
	 * 用户登录,在做具体的业务之前,需要先登陆以取得相关的认证身份信息
	 *@param szUserID   用户名,一般指资产账号
	 *@param szUserPass 用户密码
	 *@param lpReceivedMsg 用户的返回信息
	 *@param reportFlag 用户是否需要UFT主推回报，1需要，0不需要
	 *@param lpReserved 保留参数,本版本接口必须设置为NULL
	 *@return           ERR_OK表示请求成功(但此时并不表示已经登陆成功,要从lpReceivedMsg取得应答消息)
         [线程安全]
	*/}
	function DoLoginEx(const szUserID:PChar;const szUserPass:PChar;lpReceivedMsg:IFuMessage;const reportFlag:Integer;const lpReserved:Pointer = nil):Integer;virtual;stdcall;abstract;

	{/**
          *发送一个业务请求消息(反馈结果在异步回调中接收)
	  *@param lpMessage 一条业务请求消息,由用户负责管理其生命期
	  *@param iKeyID    一个自定义标识,异步应答包中会带此标识.-1表示不关心此标志(则默认异步应答以资金账号作为keyid)
          *@return ERR_OK表示发送请求成功,需要再异步回调中取相应的应答消息结果
          [非线程安全]
	*/}
	function AsyncSend(const lpReqMsg:IFuMessage;iKeyID:Integer=-1):Integer;virtual;stdcall;abstract;

	{/** 同步发送一个业务请求消息
	 *@param lpReqMsg 请求的业务消息  [in]
	 *@param lpAnsMsg 同步应答业务消息[out]
	 *@param iTimeout 超时时间,单位毫秒
	 *@return ERR_OK表示成功,其他表示失败
	 [非线程安全]
	*/}
	function SyncSendRecv(const lpReqMsg:IFuMessage;lpAnsMsg:IFuMessage;iTimeout:Integer=3000):Integer;virtual;stdcall;abstract;

	{/**
	 * 发送订阅请求,业务接收结果
	 *@param rType   订阅类型(参见REGType的定义)
	 *@param rAction 订阅/退订等动作(参见REGAction的定义)
	 *@param szParam 根据不同的rType区分:
	                 若是行情:szParam表示订阅的合约列表,以逗号分割字符串,例如WS905,a0905,cu0905,IF0905  
	                          若订阅全市场的行情,订阅代码为ALLWWW
	                          合约串只能指定一种类型(单腿或者组合)
				     若是回报/个人消息:szParam则表示待订阅的用户账号,注意这里的账号都是登陆过的账号
	 *@return ERR_OK表示请求成功(从异步应答中取订阅结果),其他表示请求失败
	 [非线程安全]
	*/}
	function SubscribeRequest(rType:REGType;rAction:REGAction;const szParam:PChar):Integer;virtual;stdcall;abstract;

	 {/*
          *用户登出
	  *@param szUserID    待登出的用户账号
	  *@param lpReserved  保留之用,V1版本必须设置为NULL
          *@return ERR_OK表示请求成功,具体可以从登陆应答中取得信息
	  [线程安全]
         */}
	function DoLogout(const szUserID:PChar;const lpReserved:Pointer = nil):Integer;virtual;stdcall;abstract;

	{/**
	  * 关闭清理通信对象,释放相应的资源
	  @return R_OK成功,其他表示失败
         [线程安全]
	*/}
	function Stop():Integer;virtual;stdcall;abstract;

	{/**
	 * 获取连接状态
         *@param iIndex连接编号.SERVICE_TYPE_TRADE - 表示交易连接 SERVICE_TYPE_QUOTE -行情(可能包含回报)连接
	 *@return 获取连接状态
         [线程安全]
	*/}
	function GetStatus(iIndex:Integer):Integer;virtual;stdcall;abstract;

	{/**
	 * 获取错误信息
	 *@param iErrNo 获取错误信息
	 *@return 获取错误信息的说明
         [线程安全]
	*/}
	function GetErrorMsg(iErrNo:Integer):PChar;virtual;stdcall;abstract;

	{/**
	 * 绑定实例相关数据
	 *@param lpKey   要绑定的数据缓冲区
          *@param iKeyLen 要绑定的数据长度
	 *@return 绑定成功,绑定失败
         [线程安全]
	*/}
	function SetKeyData(const lpKeyData:Pointer;iLen:Integer):Integer;virtual;stdcall;abstract;

	{/**
	 * 获取绑定的数据
	 *param iLen 要banding的数据长度
	 *return 返回要绑定的数据指针
         [线程安全]
	*/}
	function GetKeyData(var iLen:Integer):Pointer;virtual;stdcall;abstract;
  end;

  ////////////////////////通信异步回调接口(注意回调中的IFuMessage消息由SDK管理其生命周期)//////////////////////////////////////////////////
  IFuCallBack = class(IHSKnown)
  public
	{/**
	 * 连接状态的改变
	 *@param lpComm 通信接口对象
	 *@param iRet   返回状态标识
	 *@param szNotifyTime 发生的时间
	 *@param szMessage 说明消息
	*/}
        procedure OnConnStateNotify(lpInst:Pointer;iType:Integer;iStatus:Integer;
                                     const szNotifyTime:PChar;
                                     const szMsg:PChar);virtual;stdcall;abstract;

	{/**
	 * 登陆应答消息
	 *@param lpComm 通信接口对象
	*/}
	procedure OnRspLogin(lpInst:Pointer;lpMsg:IFuMessage);virtual;stdcall;abstract;

	{/**
	 * 登出反馈
	 *@param lpComm 通信接口对象
	*/}
	procedure OnRspLogout(lpInst:Pointer;lpMsg:IFuMessage);virtual;stdcall;abstract;

	{/**
	 *订阅\退订行情或者回报的结果
	 *@param lpComm    通信接口对象
	 *@param sType     订阅类型(单腿行情,回报等)
	 *@param aAction   请求方式(订阅,取消,取消全部,快照)
	 *@param iResult   订阅结果,-1未知失败,0订阅成功,1重复订阅,2取消成功,3没有订阅可以取消
	 *@param lpParam   附加的参数,若是回报应答,则是账号;若是行情,则是合约代码;ALLWWW表示所有;NULL未知
	 *@param szMessage 文字说明  
	*/}
        procedure OnRspSubResult(lpInst:Pointer;sType:REGType;
                                 aAction:REGAction;iResult:Integer;
                                 const lpParam:PChar;const szMsg:PChar);virtual;stdcall;abstract;

	{/**
	 * 业务接收到业务应答消息
	 *@param lpComm     通信接口对象
	 *@param lpAnsData  业务应答消息
       */}
	procedure OnReceivedBiz(lpInst:Pointer;lpAnsData:IFuMessage;iRet:Integer;iKeyID:Integer);virtual;stdcall;abstract;

	{/**
	 * 接收到单腿市场行情
	 *@param lpComm     通信接口对象
	 *@param lpInfo     单腿行情数据
	*/}
	procedure  OnRspMarketInfo(lpInst:Pointer;const lpData:LPCMarketInfo;rAction:REGAction);virtual;stdcall;abstract;

	//接收到组合市场行情
	{/**
	* 接收到单腿市场行情
	*@param lpComm     通信接口对象
	*@param lpInfo     单腿行情数据
	*/}
	procedure  OnRspArgMaketInfo(lpInst:Pointer;const lpData:LPCArgMarketInfo;rAction:REGAction);virtual;stdcall;abstract;

        {/**
	 * 接收到委托反馈消息
	 *@param lpComm     通信接口对象
	 *@param lpInfo     委托反馈消息
	*/}
	procedure OnRecvOrderInfo(lpInst:Pointer;const lpInfo:LPCOrderRspInfo);virtual;stdcall;abstract;

	{/**
	 * 接收到订单成交反馈
	 *@param lpComm     通信接口对象
	 *@param lpInfo     订单成交反馈
	*/}
        procedure OnRecvOrderRealInfo(lpInst:Pointer;const lpInfo:LPCRealRspInfo);virtual;stdcall;abstract;
        
	{/**
	 * 在线个人消息
	 *@param  lpComm    通信接口对象
	 *@param  szUsrID   消息相关的账号
	 *@param  szMessage 相关的个人消息
	*/}
        procedure OnRspOnlineMsg(lpInst:Pointer;szUsrID:PChar;szMessage:PChar);virtual;stdcall;abstract;
end;


implementation
  
end.
