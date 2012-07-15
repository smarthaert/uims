package com.bst.pro;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.http.HeaderIterator;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.CookieStore;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.cookie.Cookie;
import org.apache.http.impl.cookie.BasicClientCookie;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;
import org.apache.log4j.Logger;

import com.bst.pro.util.BasicHttpClient;

public class GTradeTest extends BasicHttpClient {
	
	static Logger log = Logger.getLogger(GTradeTest.class.getName());
	
	public static void main(String[] args) {
		//use proxy 
//		setProxy("10.100.0.6", 8080, "http");
		
//		String username = "guodayaofan@163.com";
//		String password = "bgtyhnmju";
		
		fixSelfSignedCertificate();
		setLocalCookieManger();
		
		String startPageUrl = "https://trade.gtja.com/webtrade/trade/login.jsp";
		getText(startPageUrl);
		
		String preLoginUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=preLogin";
//		cookie info
//		BranchName	Sent	上海陆家嘴东路证券营业部	/	.trade.gtja.com	(Session)		No	No
//		countType	Sent	Z	/	.trade.gtja.com	(Session)		No	No
//		JSESSIONID	Sent	2NTJPGTGJ4bCT76hbjbtxGd9l54bFy5Mjv8K8xSSSj8NyCHvXlnK!1536183329!1528435478	/	.trade.gtja.com	(Session)		No	No
//		MyBranchCodeList	Sent	3106	/	.trade.gtja.com	(Session)		No	No
//		
//		query string
//		method	preLogin
		CookieStore cookieStroe = getCookieStroe();
		BasicClientCookie cookie = new BasicClientCookie("BranchName", "%u4E0A%u6D77%u9646%u5BB6%u5634%u4E1C%u8DEF%u8BC1%u5238%u8425%u4E1A%u90E8=%u4E0A%u6D77%u9646%u5BB6%u5634%u4E1C%u8DEF%u8BC1%u5238%u8425%u4E1A%u90E8");
		cookie.setVersion(0);
		cookie.setDomain(".trade.gtja.com");
		cookie.setPath("/");
		cookieStroe.addCookie(cookie);
		
		cookie = new BasicClientCookie("countType", "Z");
		cookie.setVersion(0);
		cookie.setDomain(".trade.gtja.com");
		cookie.setPath("/");
		cookieStroe.addCookie(cookie);
		
		cookie = new BasicClientCookie("MyBranchCodeList", "3106");
		cookie.setVersion(0);
		cookie.setDomain(".trade.gtja.com");
		cookie.setPath("/");
		cookieStroe.addCookie(cookie);
		
		getText(preLoginUrl);
		
		
		
		String verifyCodeImageUrl = "https://trade.gtja.com/webtrade/commons/verifyCodeImage.jsp";
//		cookie info
//		BranchName	Sent	上海陆家嘴东路证券营业部	/	.trade.gtja.com	(Session)		No	No
//		countType	Sent	Z	/	.trade.gtja.com	(Session)		No	No
//		JSESSIONID	Sent	2NTJPGTGJ4bCT76hbjbtxGd9l54bFy5Mjv8K8xSSSj8NyCHvXlnK!1536183329!1528435478	/	.trade.gtja.com	(Session)		No	No
//		MyBranchCodeList	Sent	3106	/	.trade.gtja.com	(Session)		No	No
		String check = getChkImage(verifyCodeImageUrl);
		
		
		String getReserveMsg = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=getReserveMsg&orgid=3106&fundtype=Z&inputid=970100&ram=0.10915491733509774&_=";
		
		
		String webTradeActionUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do";
//		cookie
//		BranchName	Sent	上海陆家嘴东路证券营业部	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		countType	Sent	Z	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		JSESSIONID	Sent	2NTJPGTGJ4bCT76hbjbtxGd9l54bFy5Mjv8K8xSSSj8NyCHvXlnK!1536183329!1528435478	/	.trade.gtja.com	(Session)		No	No
//		MyBranchCodeList	Sent	3106	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
		
//		post data
//		AppendCode	46nM	15	
//		availHeight	730	15	
//		BranchCode	3106	15	
//		BranchName	上海陆家嘴东路证券营业部	119	
//		countType	Z	11	
//		flowno		7	
//		gtja_dating_login_type	0	24	
//		hardInfo		9	
//		inputid	88000049	16	
//		logintype	common	16	
//		mac		4	
//		method	login	12	
//		Page		5	
//		pwdtype		8	
//		selectBranchCode	3100	21	
//		trdpwd	OTcwMTAw	15	
//		uid	970100	10	
//		usbkeyData		11	
//		usbkeySn		9	
//		YYBFW	10	8		
		Map<String, String> postData = new HashMap<String, String>();
		postData.put("AppendCode", check);
		postData.put("availHeight", "730");
		postData.put("BranchCode", "3106");
		postData.put("BranchName", "上海陆家嘴东路证券营业部");
		postData.put("countType", "Z");
		postData.put("flowno", null);
		postData.put("gtja_dating_login_type", "0");
		postData.put("hardInfo", null);
		postData.put("inputid", "88000049");
		postData.put("logintype", "common");
		postData.put("mac", null);
		postData.put("method", "login");
		postData.put("Page", null);
		postData.put("pwdtype", null);
		postData.put("selectBranchCode", "3100");
		postData.put("trdpwd", "OTcwMTAw");
		postData.put("uid", "970100");
		postData.put("usbkeyData", null);
		postData.put("usbkeySn", null);
		postData.put("YYBFW", "10");
		
		postText(webTradeActionUrl, postData);
		
		
		String topJspUrl = "https://trade.gtja.com/webtrade/trade/top.jsp";
		getText(topJspUrl);
		
		
//		05P010705C0103030735177070967521607400161111000000001011183213021985091908140007351770706周勋建10上海陆家嘴041002000043cfebf2e49b92d1680ac111c34ae60555097670321411103org043106
		String requestToken = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=requestToken&custId=3517707&characteristic=32cfebf2e49b92d1680ac111c34ae60555&cache=0&currToken=ND000003010000&tokenRequestInfo=01010100&_=";
//		cookie info
//		BranchName	Sent	上海陆家嘴东路证券营业部	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		countType	Sent	Z	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		JSESSIONID	Sent	2NTJPGTGJ4bCT76hbjbtxGd9l54bFy5Mjv8K8xSSSj8NyCHvXlnK!1536183329!1528435478	/	.trade.gtja.com	(Session)		No	No
//		MyBranchCodeList	Sent	3106	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		
//		query string
//		_	
//		cache	0
//		characteristic	32cfebf2e49b92d1680ac111c34ae60555
//		currToken	ND000003010000
//		custId	3517707
//		method	requestToken
//		tokenRequestInfo	01010100
		getText(requestToken);
		
		
		String  PaperBuy = "https://trade.gtja.com/webtrade/trade/PaperBuy.jsp";
		
		
		String getHqUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=getHq&bsflag=B&stkcode=";
//		cookie info
//		BranchName	Sent	上海陆家嘴东路证券营业部	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		countType	Sent	Z	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		JSESSIONID	Sent	2NTJPGTGJ4bCT76hbjbtxGd9l54bFy5Mjv8K8xSSSj8NyCHvXlnK!1536183329!1528435478	/	.trade.gtja.com	(Session)		No	No
//		MyBranchCodeList	Sent	3106	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		
//		query string
//		bsflag	B
//		method	getHq
//		stkcode	601988
		getText(getHqUrl);
		
//		String webTradeAction = "https://trade.gtja.com/webtrade/trade/webTradeAction.do";
		
		
		String entrustBusinessOut = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=entrustBusinessOut";
//		cookie info
//		BranchName	Sent	上海陆家嘴东路证券营业部	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		countType	Sent	Z	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		JSESSIONID	Sent	2NTJPGTGJ4bCT76hbjbtxGd9l54bFy5Mjv8K8xSSSj8NyCHvXlnK!1536183329!1528435478	/	.trade.gtja.com	(Session)		No	No
//		MyBranchCodeList	Sent	3106	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		
//		query string
//		method	entrustBusinessOut
//		
//		post data
//		gtja_entrust_sno	1338430423004	30	
//		price	3.02	10	
//		qty	100	7	
//		radiobutton	B	13	
//		radiobutton	d	13	
//		stkcode	601988	14	
		
		
		String Papersale = "https://trade.gtja.com/webtrade/trade/Papersale.jsp";
		
		String entrustBusinessOut2 = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=entrustBusinessOut";
//		cookie info 
//		BranchName	Sent	上海陆家嘴东路证券营业部	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		countType	Sent	Z	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		JSESSIONID	Sent	2NTJPGTGJ4bCT76hbjbtxGd9l54bFy5Mjv8K8xSSSj8NyCHvXlnK!1536183329!1528435478	/	.trade.gtja.com	(Session)		No	No
//		MyBranchCodeList	Sent	3106	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		
//		query info
//		method	entrustBusinessOut
//		
//		post data
//		costprice	4.914	15	
//		gtja_entrust_sno	1338430469300	30	
//		price	4.76	10	
//		qty	1	5	
//		radiobutton	S	13	
//		radiobutton	i	13	
//		saleStatus	0	12	
//		stkcode	600428	14	
		
		
		String searchStackDetail = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=searchStackDetail";
		
		String searchEntrustDetailToday = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=searchEntrustDetailToday";
		
		String searchDealDetailToday = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=searchDealDetailToday";
		
		String getMyStockListUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=getMyStockList";
//		cookie info
//		BranchName	Sent	上海陆家嘴东路证券营业部	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		countType	Sent	Z	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		JSESSIONID	Sent	2NTJPGTGJ4bCT76hbjbtxGd9l54bFy5Mjv8K8xSSSj8NyCHvXlnK!1536183329!1528435478	/	.trade.gtja.com	(Session)		No	No
//		MyBranchCodeList	Sent	3106	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		
//		query string
//		method	getMyStockList
		getText(getMyStockListUrl);
		
		
		//0000
		String freeTokenUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=freeToken&tokenFreeInfo=ND05P010705C0103040967521607443cfebf2e49b92d1680ac111c34ae6055509767032141&_=";
//		cookie info
//		BranchName	Sent	上海陆家嘴东路证券营业部	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		countType	Sent	Z	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		JSESSIONID	Sent	2NTJPGTGJ4bCT76hbjbtxGd9l54bFy5Mjv8K8xSSSj8NyCHvXlnK!1536183329!1528435478	/	.trade.gtja.com	(Session)		No	No
//		MyBranchCodeList	Sent	3106	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		
//		query string
//		_	
//		method	freeToken
//		tokenFreeInfo	ND05P010705C0103040967521607443cfebf2e49b92d1680ac111c34ae6055509767032141
		getTextAsString(freeTokenUrl);
//		
		
		//返回登录页面
		String loginOutUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=loginOut&ssl=true";
//		cookie info
//		BranchName	Sent	上海陆家嘴东路证券营业部	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		countType	Sent	Z	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		JSESSIONID	Sent	2NTJPGTGJ4bCT76hbjbtxGd9l54bFy5Mjv8K8xSSSj8NyCHvXlnK!1536183329!1528435478	/	.trade.gtja.com	(Session)		No	No
//		MyBranchCodeList	Sent	3106	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		
//		query string
//		method	loginOut
//		ssl	true
//		
		getText(loginOutUrl);
		
		
		shutdown();
	}
}
