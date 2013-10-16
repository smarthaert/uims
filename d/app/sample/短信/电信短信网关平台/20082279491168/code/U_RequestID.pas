unit U_RequestID;

interface
  const
    Vision          :byte=$30;
    Login	          :LongWord=$00000001;	//CP或SMGW登录请求
    Login_resp	    :LongWord=$80000001;	//CP或SMGW登录的回应
    Submit	        :LongWord=$00000002;	//CP发送短消息请求
    Submit_resp	    :LongWord=$80000002;//	CP发送短消息的回应
    Deliver	        :LongWord=$00000003;	//SMGW向CP发送短消息请求
    Deliver_resp    :LongWord=$80000003;//	SMGW向CP发送短消息的回应
    Active_test	    :LongWord=$00000004;	//测试通信链路是否正常请求(由客户端发起，CP和SMGW可以通过定时发送此请求来维持连接)
    Active_test_resp:LongWord=$80000004;//	测试通信链路是否正常的回应
    xExit	          :LongWord=$00000006;//	退出请求
    Exit_resp	      :LongWord=$80000006;//	退出请求的回应
    Query	          :LongWord=$00000007;//	CP统计查询请求
    Query_resp	    :LongWord=$80000007;//	CP统计查询回应



    //可选参数标签  TLV_Lab_
    TLV_Lab_TP_pid	=$0001;
    TLV_Lab_TP_udhi	=$0002;
    TLV_Lab_LinkID	=$0003;
    TLV_Lab_ChargeUserType	=$0004;
    TLV_Lab_ChargeTermType	=$0005;
    TLV_Lab_ChargeTermPseudo	=$0006;
    TLV_Lab_DestTermType	=$0007;
    TLV_Lab_DestTermPseudo	=$0008;
    TLV_Lab_PkTotal	=$0009;
    TLV_Lab_PkNumber	=$000A;
    TLV_Lab_SubmitMsgType	=$000B;
    TLV_Lab_SPDealReslt	=$000C;
    TLV_Lab_SrcTermType	=$000D;
    TLV_Lab_SrcTermPseudo	=$000E;
    //TLV_Lab_NodesCount	=$000F;
    TLV_Lab_MsgSrc	=$0010;
    //TLV_Lab_SrcType	=$0011;
    TLV_Lab_MServiceID	=$0012;


implementation

end.
