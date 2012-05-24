package com.bst.pro;

import com.bst.pro.util.BasicHttpClient;


public class WebQQTest extends BasicHttpClient {
	public static void main(String[] args) {
		
		//http://web.qq.com/
		//
		
		//visit this page to get pgv_info and pgv_pvid login url
		//http://0.web.qstatic.com/webqqpic/js/qqweb.part1.js?t=20120504001
		
		
		//visit this page to get uikey and login_param
		//http://ui.ptlogin2.qq.com/cgi-bin/login?target=self&style=5&mibao_css=m_webqq&appid=1003903&enable_qlogin=0&no_verifyimg=1&s_url=http%3A%2F%2Fweb.qq.com%2Floginproxy.html&f_url=loginerroralert&strong_login=1&login_state=10&t=20120504001
		//Get
		//Cookie info
			//login_param	Received	target=self&style=5&mibao_css=m_webqq&appid=1003903&enable_qlogin=0&no_verifyimg=1&s_url=http%3A%2F%2Fweb.qq.com%2Floginproxy.html&f_url=loginerroralert&strong_login=1&login_state=10&t=20120504001	/	.ui.ptlogin2.qq.com	(Session)			
			//uikey	Received	aeba6f509e9afa70b0f0aa91069f2fa1449b7ba989f9bceaee6b44312c21c6fa	/	.ptlogin2.qq.com	(Session)			
			//pgv_info	Sent	pgvReferrer=&ssid=s1149252781	/	.qq.com	(Session)			
			//pgv_pvid	Sent	5301268264	/	.qq.com	Sun, 18 Jan 2038 00:00:00 GMT			
		//Query String
			//target	self
			//mibao_css	m_webqq
			//f_url	loginerroralert
			//s_url	http://web.qq.com/loginproxy.html
			//t	20120504001
			//appid	1003903
			//login_state	10
			//style	5
			//no_verifyimg	1
			//strong_login	1
			//enable_qlogin	0
		String loginUrl = "http://ui.ptlogin2.qq.com/cgi-bin/login?target=self" +
				"&style=5" +
				"&mibao_css=m_webqq" +
				"&appid=1003903" +
				"&enable_qlogin=0" +
				"&no_verifyimg=1" +
				"&s_url=http%3A%2F%2Fweb.qq.com%2Floginproxy.html" +
				"&f_url=loginerroralert" +
				"&strong_login=1" +
				"&login_state=10" +
				"&t=20120504001";
		
		
		//http://check.ptlogin2.qq.com/check?uin=12442835&appid=1003903&r=0.5984531447826229
		//http://check.ptlogin2.qq.com/check?uin=12442835&appid=1003903&r=0.14580550963103628
		//Get
		//Cookie info 
				//ptvfsession	Received	54e9c3dabe004e57146a09c6db66f7c035a3b7161c6b44a23becdff3b7e8ec01f703fc3a5c164a3dad219719eee400bc	/	.ptlogin2.qq.com	(Session)			
				//confirmuin	Received	12442835	/	.ptlogin2.qq.com	(Session)			
				//uikey	Sent	aeba6f509e9afa70b0f0aa91069f2fa1449b7ba989f9bceaee6b44312c21c6fa	/	.ptlogin2.qq.com	(Session)			
				//pgv_pvid	Sent	5301268264	/	.qq.com	Sun, 18 Jan 2038 00:00:00 GMT			
				//pgv_info	Sent	pgvReferrer=&ssid=s1149252781	/	.qq.com	(Session)			
				//chkuin	Sent	12442835	/	.ptlogin2.qq.com	(Session)			
		//Query String
				//appid	1003903
			//r	0.5984531447826229
				//uin	12442835
		
		
		//if not login in c client use this url to info server
		//http://ui.ptlogin2.qq.com/cgi-bin/report?id=195390&t=0.12183949630654428
		//GET
		//Cookie Info
				//chkuin	Sent	12442835	/	.ptlogin2.qq.com	(Session)			
				//confirmuin	Sent	12442835	/	.ptlogin2.qq.com	(Session)			
				//login_param	Sent	target=self&style=5&mibao_css=m_webqq&appid=1003903&enable_qlogin=0&no_verifyimg=1&s_url=http%3A%2F%2Fweb.qq.com%2Floginproxy.html&f_url=loginerroralert&strong_login=1&login_state=10&t=20120504001	/	.ui.ptlogin2.qq.com	(Session)			
				//pgv_info	Sent	pgvReferrer=&ssid=s1149252781	/	.qq.com	(Session)			
				//pgv_pvid	Sent	5301268264	/	.qq.com	Sun, 18 Jan 2038 00:00:00 GMT			
			//ptui_check_rem_uin	Sent	5	/	.ui.ptlogin2.qq.com	(Session)			
				//ptvfsession	Sent	54e9c3dabe004e57146a09c6db66f7c035a3b7161c6b44a23becdff3b7e8ec01f703fc3a5c164a3dad219719eee400bc	/	.ptlogin2.qq.com	(Session)			
				//uikey	Sent	aeba6f509e9afa70b0f0aa91069f2fa1449b7ba989f9bceaee6b44312c21c6fa	/	.ptlogin2.qq.com	(Session)			
		//Query String
			//id	195390
			//t	0.12183949630654428
		
		//
		//http://ptlogin2.qq.com/login?u=12442835&p=637D0E0A47CC01FA7785CC32D0146CE7&verifycode=!E1W&webqq_type=10&remember_uin=1&login2qq=1&aid=1003903&u1=http%3A%2F%2Fweb.qq.com%2Floginproxy.html%3Flogin2qq%3D1%26webqq_type%3D10&h=1&ptredirect=0&ptlang=2052&from_ui=1&pttype=1&dumy=&fp=loginerroralert&action=3-16-11907&mibao_css=m_webqq&t=1&g=1
		//http://ptlogin2.qq.com/login?u=12442835&p=BA711BB6DC7256EDE236D37D27E6AA52&verifycode=!2T8&webqq_type=10&remember_uin=1&login2qq=1&aid=1003903&u1=http%3A%2F%2Fweb.qq.com%2Floginproxy.html%3Flogin2qq%3D1%26webqq_type%3D10&h=1&ptredirect=0&ptlang=2052&from_ui=1&pttype=1&dumy=&fp=loginerroralert&action=3-18-22829&mibao_css=m_webqq&t=1&g=1
		//GET
		//Cookie Info
				//airkey	Received		/	.qq.com	Fri, 02-Jan-1970 00:00:00 GMT			
				//clientkey	Received		/	.qq.com	Fri, 02-Jan-1970 00:00:00 GMT			
				//clientuin	Received		/	.qq.com	Fri, 02-Jan-1970 00:00:00 GMT			
				//pt2gguin	Received	o0012442835	/	.qq.com	Fri, 02-Jan-2020 00:00:00 GMT			
				//ptcz	Received	88f50378323a26ee8a54e91ee5542bc7fd9a3b00d9e28c2c7ccf02693f58d49a	/	.ptlogin2.qq.com	Fri, 02-Jan-2020 00:00:00 GMT			
				//ptisp	Received	ctc	/	.qq.com	(Session)			
				//ptuserinfo	Received	2f73756e4a616d79	/	.ptlogin2.qq.com	(Session)			
				//ptwebqq	Received	7d84e543b6ca6eb47cb53b4ec4d2888e3dea32d13cec9f7b545e1fedeea5fc09	/	.qq.com	(Session)			
				//show_id	Received		/	.qq.com	(Session)			
				//skey	Received	@jTRjZlDKG	/	.qq.com	(Session)			
				//uin	Received	o0012442835	/	.qq.com	(Session)			
				//zzpanelkey	Received		/	.qq.com	Fri, 02-Jan-1970 00:00:00 GMT			
				//zzpaneluin	Received		/	.qq.com	Fri, 02-Jan-1970 00:00:00 GMT			
				//chkuin	Sent	12442835	/	.ptlogin2.qq.com	(Session)			
				//confirmuin	Sent	12442835	/	.ptlogin2.qq.com	(Session)			
				//pgv_info	Sent	pgvReferrer=&ssid=s1149252781	/	.qq.com	(Session)			
				//pgv_pvid	Sent	5301268264	/	.qq.com	Sun, 18 Jan 2038 00:00:00 GMT			
				//ptvfsession	Sent	54e9c3dabe004e57146a09c6db66f7c035a3b7161c6b44a23becdff3b7e8ec01f703fc3a5c164a3dad219719eee400bc	/	.ptlogin2.qq.com	(Session)			
				//uikey	Sent	aeba6f509e9afa70b0f0aa91069f2fa1449b7ba989f9bceaee6b44312c21c6fa	/	.ptlogin2.qq.com	(Session)			
		//Query String
			//mibao_css	m_webqq
			//fp	loginerroralert
			//u1	http://web.qq.com/loginproxy.html?login2qq=1&webqq_type=10
				//u	12442835
			//aid	1003903
			//ptlang	2052
			//p	637D0E0A47CC01FA7785CC32D0146CE7
			//webqq_type	10
			//action	3-16-11907
			//from_ui	1
			//g	1
			//h	1
			//login2qq	1
			//pttype	1
			//remember_uin	1
			//t	1
			//ptredirect	0
			//verifycode	!E1W
			//dumy	
		//------------------------------------------------------------------------------------------------
		
		
		//http://web.qq.com/loginproxy.html?login2qq=1&webqq_type=10
		//http://web.qq.com/loginproxy.html?login2qq=1&webqq_type=10
		//
		//http://cgi.web2.qq.com/keycgi/qqweb/newuac/get.do
		//http://cgi.web2.qq.com/keycgi/qqweb/newuac/get.do
		//
		//
		//http://d.web2.qq.com/proxy.html?v=20110331002&callback=2
		//http://d.web2.qq.com/proxy.html?v=20110331002&callback=2
		//
		
		
		//------------------------------------------------------------------------------------------------
		//send msg use this url
		//http://d.web2.qq.com/channel/send_buddy_msg2
		//POST
		//Cookie info
			//uin	Sent	o0012442835	/	.qq.com	(Session)			
			//skey	Sent	@MarOQb3KS	/	.qq.com	(Session)			
			//show_id	Sent		/	.qq.com	(Session)			
			//ptwebqq	Sent	2def876cef83a862c4ec68725132d4935c609a019da1ed47d5a96bb26e08cbbc	/	.qq.com	(Session)			
			//ptui_loginuin	Sent	12442835	/	.qq.com	(Session)			
			//ptisp	Sent	ctc	/	.qq.com	(Session)			
			//pt2gguin	Sent	o0012442835	/	.qq.com	Fri, 02-Jan-2020 00:00:00 GMT			
			//pgv_pvid	Sent	9690176028	/	.qq.com	Sun, 18 Jan 2038 00:00:00 GMT			
			//pgv_info	Sent	pgvReferrer=&ssid=s9255102332	/	.qq.com	(Session)			
		//Query String
		//POST Data
			//clientid	33477343	17	
			//psessionid	8368046764001d636f6e6e7365727665725f77656271714031302e3133342e362e31333800002a2f000012a6026200bddcd36d0000000a404d61724f5162334b536d0000002851452193876071c41b71358bd5fd96b5e524ca802f34ee75603cc70d893a87085ccb705b4b33c00c	231	
			//r	{"to":2804445667,"face":234,"content":"[\"\\u8bf7\\u56de\\u4e2a\\u6d88\\u606f \\u5475\\u5475\",[\"font\",{\"name\":\"\\u5b8b\\u4f53\",\"size\":\"10\",\"style\":[0,0,0],\"color\":\"000000\"}]]","msg_id":24770002,"clientid":"33477343","psessionid":"8368046764001d636f6e6e7365727665725f77656271714031302e3133342e362e31333800002a2f000012a6026200bddcd36d0000000a404d61724f5162334b536d0000002851452193876071c41b71358bd5fd96b5e524ca802f34ee75603cc70d893a87085ccb705b4b33c00c"}	681	
		
		//
		//get msg use this url(in loop)
		//{"retcode":0,"result":[{"poll_type":"message","value":{"msg_id":11999,"from_uin":2804445667,"to_uin":12442835,"msg_id2":29285,"msg_type":9,"reply_ip":176881868,"time":1337172573,"content":[["font",{"size":15,"color":"8000ff","style":[0,0,0],"name":"\u5B8B\u4F53"}],["face",100]," "]}}]}
		//http://d.web2.qq.com/channel/poll2
		//POST
		//Cookie Info
			//uin	Sent	o0012442835	/	.qq.com	(Session)			
			//skey	Sent	@MarOQb3KS	/	.qq.com	(Session)			
			//show_id	Sent		/	.qq.com	(Session)			
			//ptwebqq	Sent	2def876cef83a862c4ec68725132d4935c609a019da1ed47d5a96bb26e08cbbc	/	.qq.com	(Session)			
			//ptui_loginuin	Sent	12442835	/	.qq.com	(Session)			
			//ptisp	Sent	ctc	/	.qq.com	(Session)			
			//pt2gguin	Sent	o0012442835	/	.qq.com	Fri, 02-Jan-2020 00:00:00 GMT			
			//pgv_pvid	Sent	9690176028	/	.qq.com	Sun, 18 Jan 2038 00:00:00 GMT			
			//pgv_info	Sent	pgvReferrer=&ssid=s9255102332	/	.qq.com	(Session)			
		//Query String
		//POST Data
			//clientid	33477343	17	
			//psessionid	8368046764001d636f6e6e7365727665725f77656271714031302e3133342e362e31333800002a2f000012a6026200bddcd36d0000000a404d61724f5162334b536d0000002851452193876071c41b71358bd5fd96b5e524ca802f34ee75603cc70d893a87085ccb705b4b33c00c	231	
			//r	{"clientid":"33477343","psessionid":"8368046764001d636f6e6e7365727665725f77656271714031302e3133342e362e31333800002a2f000012a6026200bddcd36d0000000a404d61724f5162334b536d0000002851452193876071c41b71358bd5fd96b5e524ca802f34ee75603cc70d893a87085ccb705b4b33c00c","key":0,"ids":[]}	324	
	}
}
