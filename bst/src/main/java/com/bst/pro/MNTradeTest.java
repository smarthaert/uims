package com.bst.pro;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;
import java.util.logging.Logger;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.CookieStore;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.params.ClientPNames;
import org.apache.http.client.params.CookiePolicy;
import org.apache.http.client.protocol.ClientContext;
import org.apache.http.cookie.Cookie;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import org.jsoup.nodes.Document;

import com.bst.pro.util.ImageResponseHandler;
import com.bst.pro.util.JsoupResponseHandler;

public class MNTradeTest {
	static Logger log = Logger.getLogger(MNTradeTest.class.getName());
	
	
	//create httpclient
	static HttpClient httpclient = new DefaultHttpClient();
	//create context
	static HttpContext localContext = new BasicHttpContext();
	//create cookie manager
	static CookieStore cookieStroe = new BasicCookieStore();
	
	public static void main(String[] args) {
		

		//bind cookie manager to context
		localContext.setAttribute(ClientContext.COOKIE_STORE, cookieStroe);
		localContext.setAttribute(ClientPNames.COOKIE_POLICY, CookiePolicy.BROWSER_COMPATIBILITY);
		
		//run application rule
		//first visit url: http://mntrade.gtja.com/mncg/login/login.jsp
		String loginUrl = "http://mntrade.gtja.com/mncg/login/login.jsp";
		getText(loginUrl);
		
		//second 
		String bindUrl = "http://www.gtja.com/jccy/mncg/mncgBind.jsp?from=cmncg&roomId=null";
		getText(bindUrl);
		
		
		HttpGet httpget = new HttpGet(
		"http://www.gtja.com/share/verifyCodeWhite.jsp");

		ResponseHandler<String> irh = new ImageResponseHandler();
		String imgPath = null;
		try {
			imgPath = httpclient.execute(httpget, irh, localContext);
			cookieDisplay(cookieStroe);
		} catch (ClientProtocolException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} finally {
			httpget.abort();
		}
		
		log.info("请打开" + imgPath + "，并且在这里输入其中的字符串，然后回车：");
		InputStreamReader isr = new InputStreamReader(System.in);
		BufferedReader br = new BufferedReader(isr);
		String check = null;
		try {
			check = br.readLine();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		httpclient.getConnectionManager().shutdown();
		
		
		
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
				
				//ͼƬ
			//http://www.gtja.com/share/verifyCodeWhite.jsp?rand=0.15123428517051063
				//JSESSIONID	Sent	T14hPq0T7fFysLWz8bTyHTqPGlmv9v1LThgLJnzGKzhRnhznhkcQ!972763046!-818033016	/	www.gtja.com	(Session)	Server	No	No
				//rand	0.15123428517051063
				
				//ͼƬ
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

				//ģ�⳴��ϵͳ
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

	/**
	 * @param httpclient
	 * @param localContext
	 * @param cookieStroe
	 */
	private static void getText(String url) {
		HttpGet httpget = new HttpGet(url);
		ResponseHandler<Document> jrh = new JsoupResponseHandler();
		try {
			Document loginPage = httpclient.execute(httpget, jrh, localContext);
			cookieDisplay(cookieStroe);
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			httpget.abort();
		}
	}

	/**
	 * @param cookieStroe
	 */
	private static void cookieDisplay(CookieStore cookieStroe) {
		List<Cookie> cookies = cookieStroe.getCookies();
		for(Cookie cookie : cookies){
			log.info(">>>" + cookie.getName() + " : " + cookie.getValue() + " | " + cookie.getDomain());
		}
	}
}
