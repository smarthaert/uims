package com.bst.pro;

import org.apache.http.conn.params.ConnRoutePNames;
import org.apache.http.impl.client.DefaultHttpClient;

public class MNTradeTest {
	public static void main(String[] args) {
//		DefaultHttpClient dhc = new DefaultHttpClient();
//		dhc.getParams().setParameter(ConnRoutePNames.DEFAULT_PROXY, new HttpHost("10.100.0.6", 8080));
//		
		
		//http://mntrade.gtja.com/mncg/login/login.jsp
			//MNCGJSESSIONID	Received	2ndzPq0T26WflHMsvxJ1k7XV2pQW81PVFQG1X0nBGVFKyYdSq484!-26193917	/	mntrade.gtja.com	(Session)	Server	No	No
			
			//http://www.gtja.com/jccy/mncg/mncgBind.jsp?from=cmncg&roomId=null
				//from	cmncg
				//roomId	null
		
				//JSESSIONID	Received	T14hPq0T7fFysLWz8bTyHTqPGlmv9v1LThgLJnzGKzhRnhznhkcQ!972763046!-818033016	/	www.gtja.com	(Session)	Server	No	No
			//http://www.gtja.com/jccy/mncg/mncgLogin.jsp?forMncgMickBind=1
				//JSESSIONID	Sent	T14hPq0T7fFysLWz8bTyHTqPGlmv9v1LThgLJnzGKzhRnhznhkcQ!972763046!-818033016	/	www.gtja.com	(Session)	Server	No	No
				//forMncgMickBind	1
				
				//<iframe name="logframe" id="logframe" src="/flagshop/login/loginTyyh.jsp?forMncgReBind=&forMncgMickBind=1&isGeneral=1&longType=mncg&isSingle=0&characteristic=null&checktoken=null&systype=null"  border="0" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="490" height="488px" ></iframe>
			//http://www.gtja.com/flagshop/login/loginTyyh.jsp?forMncgReBind=&forMncgMickBind=1&isGeneral=1&longType=mncg&isSingle=0&characteristic=null&checktoken=null&systype=null
				//JSESSIONID	Sent	T14hPq0T7fFysLWz8bTyHTqPGlmv9v1LThgLJnzGKzhRnhznhkcQ!972763046!-818033016	/	www.gtja.com	(Session)	Server	No	No
				//characteristic	null
				//checktoken	null
				//forMncgMickBind	1
				//forMncgReBind	
				//isGeneral	1
				//isSingle	0
				//longType	mncg
				//systype	null
			//http://www.gtja.com/share/verifyCodeWhite.jsp
				//JSESSIONID	Sent	T14hPq0T7fFysLWz8bTyHTqPGlmv9v1LThgLJnzGKzhRnhznhkcQ!972763046!-818033016	/	www.gtja.com	(Session)	Server	No	No
				
				//图片
			//http://www.gtja.com/share/verifyCodeWhite.jsp?rand=0.15123428517051063
				//JSESSIONID	Sent	T14hPq0T7fFysLWz8bTyHTqPGlmv9v1LThgLJnzGKzhRnhznhkcQ!972763046!-818033016	/	www.gtja.com	(Session)	Server	No	No
				//rand	0.15123428517051063
				
				//图片
			//http://www.gtja.com/login/verificationLoginInterface.jsp?m=0.5218843634038155&uName=hell&tickUserName=on&pwd=123456&verifyCode=4617&characteristic=null&systype=null&userName=hell&passWord=MTIzNDU2&passWord1=4444&userCode=2&longType=mncg&newPath=null&BranchName=&Page=&isSingle=0&iframe=&userLevel=&employeeId=&currentToken=&method=
				//checksavetykLoginUserName	Sent	0	/	www.gtja.com	(Session)	JavaScript	No	No
				//JSESSIONID	Sent	T14hPq0T7fFysLWz8bTyHTqPGlmv9v1LThgLJnzGKzhRnhznhkcQ!972763046!-818033016	/	www.gtja.com	(Session)	Server	No	No
				//tykLoginUserName	Sent	null	/	www.gtja.com	(Session)	JavaScript	No	No
				//POST
				//BranchName	
				//characteristic	null
				//currentToken	
				//employeeId	
				//iframe	
				//isSingle	0
				//longType	mncg
				//m	0.5218843634038155
				//method	
				//newPath	null
				//Page	
				//passWord	MTIzNDU2
				//passWord1	4444
				//pwd	123456
				//systype	null
				//tickUserName	on
				//uName	hell
				//userCode	2
				//userLevel	
				//userName	hell
				//verifyCode	4617
				
				//{"isSingle":"0","logId":19501459,"currentToken":"4EED229F8349C7A9858F49C870715C99DAECF79C1776654B23B2E6BFB065C4F65F43AE149E21484DE06354273371FCCA4886E6881012A851A4F6BDD1A19FEFC177EAE466E9AEF68EC5130472EBF2C14AEE0FCC347C0BE66B2AEE793ECE72AA4010701A7064D2FD95A0F4FCAD07BE506F","verificationEmployeeId":"hell","verificationUserLevel":"1003"}
			//http://www.gtja.com/single.do
				//checksavetykLoginUserName	Sent	0	/	www.gtja.com	(Session)	JavaScript	No	No
				//JSESSIONID	Sent	T14hPq0T7fFysLWz8bTyHTqPGlmv9v1LThgLJnzGKzhRnhznhkcQ!972763046!-818033016	/	www.gtja.com	(Session)	Server	No	No
				//tykLoginUserName	Sent	null	/	www.gtja.com	(Session)	JavaScript	No	No
				//POST
				//BranchName		11	
				//characteristic	null	19	
				//currentToken	4EED229F8349C7A9858F49C870715C99DAECF79C1776654B23B2E6BFB065C4F65F43AE149E21484DE06354273371FCCA4886E6881012A851A4F6BDD1A19FEFC177EAE466E9AEF68EC5130472EBF2C14AEE0FCC347C0BE66B2AEE793ECE72AA4010701A7064D2FD95A0F4FCAD07BE506F	237	
				//employeeId	hell	15	
				//iframe		7	
				//isSingle	0	10	
				//longType	mncg	13	
				//method	userLogin	16	
				//newPath	null	12	
				//Page		5	
				//passWord	MTIzNDU2	17	
				//passWord1	4444	14	
				//pwd	123456	10	
				//systype	null	12	
				//uName	hell	10	
				//userCode	2	10	
				//userLevel	1003	14	
				//userName	hell	13	
				//verifyCode	4617	15	
				
				//<a href="http://www.gtja.com/jccy/mncg/mncgBindJump.jsp?from=cmncg">http://www.gtja.com/jccy/mncg/mncgBindJump.jsp?from=cmncg</a>
			//http://www.gtja.com/jccy/mncg/mncgBindJump.jsp?from=cmncg
				//checksavetykLoginUserName	Sent	0	/	www.gtja.com	(Session)	JavaScript	No	No
				//JSESSIONID	Sent	T14hPq0T7fFysLWz8bTyHTqPGlmv9v1LThgLJnzGKzhRnhznhkcQ!972763046!-818033016	/	www.gtja.com	(Session)	Server	No	No
				//tykLoginUserName	Sent	null	/	www.gtja.com	(Session)	JavaScript	No	No
				//from	cmncg
				
				//window.top.location = "http://www.gtja.com/jccy/mncg/toMncg.jsp";
			//http://www.gtja.com/jccy/mncg/toMncg.jsp
				//checksavetykLoginUserName	Sent	0	/	www.gtja.com	(Session)	JavaScript	No	No
				//JSESSIONID	Sent	T14hPq0T7fFysLWz8bTyHTqPGlmv9v1LThgLJnzGKzhRnhznhkcQ!972763046!-818033016	/	www.gtja.com	(Session)	Server	No	No
				//tykLoginUserName	Sent	null	/	www.gtja.com	(Session)	JavaScript	No	No
			
				//	<form action="http://et.gtjadev.com:8085/mncg/usersAction.do" method="post" name="mncgform">
				//		<input type="hidden" name="method" value="opinionUserInfo"></input>
				//		<input type="hidden" name="mncg" value="PGVtcHR5PjxmZ2Y*aGVsbDxmZ2Y*MjxmZ2Y*MTM2MTE5MTM3NDE8ZmdmPjxlbXB0eT48ZmdmPm51bGw="></input>
				//		<input type="hidden" name="timestamp" value="time"></input>
				//		<input type="hidden" name="sign" value="0d02c23e98fdf42f429200100b69f3cb"></input>
				//	</form>
				//document.location="http://mntrade.gtja.com/mncg/usersAction.do?method=loginMncg&mncg=PGVtcHR5PjxmZ2Y*aGVsbDxmZ2Y*MjxmZ2Y*MTM2MTE5MTM3NDE8ZmdmPjxlbXB0eT48ZmdmPm51bGw=&timestamp=1336554209625&sign=0d02c23e98fdf42f429200100b69f3cb";
		
			//http://mntrade.gtja.com/mncg/usersAction.do?method=loginMncg&mncg=PGVtcHR5PjxmZ2Y*aGVsbDxmZ2Y*MjxmZ2Y*MTM2MTE5MTM3NDE8ZmdmPjxlbXB0eT48ZmdmPm51bGw=&timestamp=1336554209625&sign=0d02c23e98fdf42f429200100b69f3cb
				//MNCGJSESSIONID	Sent	2ndzPq0T26WflHMsvxJ1k7XV2pQW81PVFQG1X0nBGVFKyYdSq484!-26193917	/	mntrade.gtja.com	(Session)	Server	No	No
				//method	loginMncg
				//mncg	PGVtcHR5PjxmZ2Y*aGVsbDxmZ2Y*MjxmZ2Y*MTM2MTE5MTM3NDE8ZmdmPjxlbXB0eT48ZmdmPm51bGw=
				//sign	0d02c23e98fdf42f429200100b69f3cb
				//timestamp	1336554209625

				//模拟炒股系统
			//http://mntrade.gtja.com/mncg/roomIndexAction.do?method=getMyRoom&current_page=1
				//MNCGJSESSIONID	Sent	2ndzPq0T26WflHMsvxJ1k7XV2pQW81PVFQG1X0nBGVFKyYdSq484!-26193917	/	mntrade.gtja.com	(Session)	Server	No	No
				//current_page	1
				//method	getMyRoom
			//http://mntrade.gtja.com/mncg/loginAction.do?method=loginRoom&edition=pro&roomId=1
				//MNCGJSESSIONID	Sent	2ndzPq0T26WflHMsvxJ1k7XV2pQW81PVFQG1X0nBGVFKyYdSq484!-26193917	/	mntrade.gtja.com	(Session)	Server	No	No
				//edition	pro
				//method	loginRoom
				//roomId	1
	}
}
