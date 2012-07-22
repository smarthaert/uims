package com.bst.pro;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import net.sf.json.JSONException;
import net.sf.json.JSONObject;

import org.apache.http.HttpHost;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.CookieStore;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.params.ClientPNames;
import org.apache.http.client.params.CookiePolicy;
import org.apache.http.client.protocol.ClientContext;
import org.apache.http.conn.params.ConnRoutePNames;
import org.apache.http.cookie.Cookie;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.cookie.BasicClientCookie;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HTTP;
import org.apache.http.protocol.HttpContext;
import org.apache.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import com.bst.pro.util.DealDecision;
import com.bst.pro.util.ImageResponseHandler;
import com.bst.pro.util.JSONObjectResponseHandler;
import com.bst.pro.util.JsoupResponseHandler;
import com.bst.pro.util.PanKou;
import com.bst.pro.util.StockInfo;
import com.bst.pro.util.StockReport;

public class MNTradeTest {
	static Logger log = Logger.getLogger(MNTradeTest.class.getName());

//	static HttpHost proxy = new HttpHost("10.100.0.6", 8080, "http");

	// create httpclient
	static HttpClient httpclient = new DefaultHttpClient();
	// create context
	static HttpContext localContext = new BasicHttpContext();
	// create cookie manager
	static CookieStore cookieStroe = new BasicCookieStore();

	public static void main(String[] args) {
		// set http proxy
//		httpclient.getParams().setParameter(ConnRoutePNames.DEFAULT_PROXY,
//				proxy);

		// bind cookie manager to context
		localContext.setAttribute(ClientContext.COOKIE_STORE, cookieStroe);
		localContext.setAttribute(ClientPNames.COOKIE_POLICY,
				CookiePolicy.BROWSER_COMPATIBILITY);

		// run application rule
		// first visit url: http://mntrade.gtja.com/mncg/login/login.jsp
		String loginUrl = "http://mntrade.gtja.com/mncg/login/login.jsp";
		getText(loginUrl);

		// second
		String bindUrl = "http://www.gtja.com/jccy/mncg/mncgBind.jsp?from=cmncg&roomId=null";
		getText(bindUrl);

		// get check image
		String check = getChkImage();

		// real login
		String currentToken = loginInterfacePost(check);

		// single login
		singleLoginPost(check, currentToken);

		// visit toMncy.jsp
		// get mncy and sign values
		String toMncyUrl = "http://www.gtja.com/jccy/mncg/toMncg.jsp";
		Document doc = getText(toMncyUrl);

		String jsStr = doc.select("script").toString();
		//use regex util to get info
		Pattern p = Pattern.compile("document.location=\"([^\\\"]+)\"");
		Matcher m = p.matcher(jsStr);
		String loginMncgUrl = null;
		if (m.find()) {
			loginMncgUrl = m.group(1);
			log.info(loginMncgUrl);
		}
		// get url from the jsStr

		// String mncg = doc.select("form input[name=mncg]").attr("value");
		// String sign = doc.select("form input[name=sign]").attr("value");

		// visit usersAction.jsp to login mncg model
		// String loginMncgUrl = "http://mntrade.gtja.com/mncg/usersAction.do" +
		// "?method=loginMncg&" +
		// "mncg=" +
		// mncg +
		// "timestamp=1337058343867&" +
		// "sign=" +
		// sign;
		// the timestamp value is very important, for the server will check the
		// current time to make sure request is valid.
		getText(loginMncgUrl);

		// visit my room page
		// get all the bisai 
		String myRoomUrl = "http://mntrade.gtja.com/mncg/roomIndexAction.do?method=getMyRoom&current_page=1";
		postText(myRoomUrl);
		

		String loginRoomUrl = "http://mntrade.gtja.com/mncg/loginAction.do?method=loginRoom&edition=pro&roomId=1";
		getText(loginRoomUrl);
		
		
		String getFundsUrl = "http://mntrade.gtja.com/mncg/stockAction.do?method=getFunds";
		String rpStr = postText(getFundsUrl);
		//每天报告资产总值和盈亏
		Document rpDoc = Jsoup.parse(rpStr);
		StockReport sr = new StockReport(rpDoc);
		

		//根据盈亏情况决定是否卖出
		//http://mntrade.gtja.com/mncg/stockAction.do?method=getStockPosition&current_page=1
		String stockListPageUrl = "http://mntrade.gtja.com/mncg/stockAction.do?method=getStockPosition&current_page=1";
		String stockListStr = postText(stockListPageUrl);
		Document slDoc = Jsoup.parse(stockListStr);
		DealDecision dd = new DealDecision(slDoc);
		List<StockInfo> sellStockList = dd.getSellStock();
		for(StockInfo si : sellStockList){
			String ret = sellStock(si);
			log.info(ret);
		}
		
		//查询挂单，对于已经成交的短信通知。
		
		
		
		//委托成功短信通知
		//{cssweb_type:'success',cssweb_msg:'委托成功，委托编号为：1011473'}

		//logout the system
		
		httpclient.getConnectionManager().shutdown();
	}

	private static String sellStock(StockInfo si) {
		// query stock info by id
		String stockCode = si.getStockCode();
		String qty = Integer.toBinaryString(si.getStockQuantity());
		String pankouStr = queryStockByCode(stockCode);
		Document pkDoc = Jsoup.parse(pankouStr);
		PanKou pk = new MNTPanKou(pkDoc, 1);
		//get the price
		String price = new Float(pk.getSellPrice(Integer.parseInt(qty))).toString();
		
		
		//sell stock 
		//http://mntrade.gtja.com/mncg/stockAction.do?method=saleStock
		//Cookie info
			//MNCGJSESSIONID	Sent	v2m1P2nBBHTMJ2DqQrQh7hv16ZJ80SlPD752ftwJkyyj1bh22LVh!-26193917	/	mntrade.gtja.com	(Session)	Server	No	No
		//Query String 
			//method	saleStock
		//Post Data
			//bsflag	2	8	
			//market	0	8	
			//price	15.68	11	//价格
			//qty	7	5	//数量
			//saleStatus	0	12	
			//seat	undefined	14	
			//secuid	85900	12	//资金帐号
			//stkcode	300148	14	//股票代码
		//Result
			//{cssweb_type:'success',cssweb_msg:'委托成功，委托编号为：1011376'}
		
		String sellStockUrl = "http://mntrade.gtja.com/mncg/stockAction.do?method=saleStock";
		Map<String, String> postData = new HashMap<String, String>();
		
		postData.put("bsflag", "2");//b8	
		postData.put("market", "0");//m8	
		postData.put("price", price);//p11	
		postData.put("qty", qty);//q5	
		postData.put("saleStatus", "0");//s12	
		postData.put("seat", "undefined");//s14	
		postData.put("secuid", "85900");//s12	
		postData.put("stkcode", stockCode);//s14	
		
		String ret = postText(sellStockUrl, postData);
		return ret;
	}

	/**
	 * @param stockCode
	 */
	private static String queryStockByCode(String stockCode) {
		String queryStr = "http://mntrade.gtja.com/mncg/stockAction.do?method=getHQ&stkcode=" +
				stockCode +
				"&bsflag=1";

		return postText(queryStr);
	}

	private static String postText(String queryStr) {
		HttpPost loginPost = new HttpPost(queryStr);

		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		try {
			loginPost.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}

		ResponseHandler<String> brh = new BasicResponseHandler();
		String responseBody = null;
		try {
			responseBody = httpclient.execute(loginPost, brh,
					localContext);
			log.debug(responseBody);

			cookieDisplay(cookieStroe);

		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		} finally {
			loginPost.abort();
		}
		return responseBody; 
	}
	
	/**
	 * 带参数POST
	 * @param url
	 * @param values
	 * @return
	 */
	protected static String postText(String url, Map<String, String> values) {
		HttpPost httppost = new HttpPost(url);
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		for (Map.Entry<String, String> e : values.entrySet()) {
			nvps.add(new BasicNameValuePair(e.getKey(), e.getValue()));
		}
		// Create a response handler
		ResponseHandler<String> brh = new BasicResponseHandler();
		String responseBody = "";
		try {
			httppost.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));
			responseBody = httpclient.execute(httppost, brh,
					localContext);
		} catch (Exception e) {
			e.printStackTrace();
			responseBody = null;
		} finally {
			httppost.abort();
			// httpclient.getConnectionManager().shutdown();
		}
		return responseBody;
	}

	private static void singleLoginPost(String check, String currentToken) {
		HttpPost singleloginPost = new HttpPost("http://www.gtja.com/single.do");

		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("BranchName", ""));
		nvps.add(new BasicNameValuePair("characteristic", "null"));
		nvps.add(new BasicNameValuePair("currentToken", currentToken));
		nvps.add(new BasicNameValuePair("employeeId", "hell"));
		nvps.add(new BasicNameValuePair("iframe", ""));
		nvps.add(new BasicNameValuePair("isSingle", "0"));
		nvps.add(new BasicNameValuePair("longType", "mncg"));
		nvps.add(new BasicNameValuePair("method", "userLogin"));
		nvps.add(new BasicNameValuePair("newPath", "null"));
		nvps.add(new BasicNameValuePair("Page", ""));
		nvps.add(new BasicNameValuePair("passWord", "MTIzNDU2"));
		nvps.add(new BasicNameValuePair("passWord1", "4444"));
		nvps.add(new BasicNameValuePair("pwd", "123456"));
		nvps.add(new BasicNameValuePair("systype", "null"));
		nvps.add(new BasicNameValuePair("uName", "hell"));
		nvps.add(new BasicNameValuePair("userCode", "2"));
		nvps.add(new BasicNameValuePair("userLevel", "1003"));
		nvps.add(new BasicNameValuePair("userName", "hell"));
		nvps.add(new BasicNameValuePair("verifyCode", check));

		try {
			singleloginPost
					.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}

		ResponseHandler<Document> jrh = new JsoupResponseHandler();
		try {
			Document doc = httpclient.execute(singleloginPost, jrh,
					localContext);
			log.debug(doc.select("a").attr("href"));
			cookieDisplay(cookieStroe);

		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			singleloginPost.abort();
		}
	}

	/**
	 * @param check
	 * @return
	 */
	private static String loginInterfacePost(String check) {
		HttpPost loginPost = new HttpPost(
				"http://www.gtja.com/login/verificationLoginInterface.jsp"
						+ "?m=0.5218843634038155"
						+ "&uName=hell&tickUserName=on"
						+ "&pwd=123456"
						+ "&verifyCode="
						+ check
						+ "&characteristic=null"
						+ "&systype=null"
						+ "&userName=hell"
						+ "&passWord=MTIzNDU2"
						+ // todo
						"&passWord1=4444"
						+ // todo
						"&userCode=2" + "&longType=mncg" + "&newPath=null"
						+ "&BranchName=" + "&Page=" + "&isSingle=0"
						+ "&iframe=" + "&userLevel=" + "&employeeId="
						+ "&currentToken=" + "&method=");

		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		try {
			loginPost.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}

		BasicClientCookie tykLoginUserName = new BasicClientCookie(
				"tykLoginUserName", "null");
		tykLoginUserName.setDomain("www.gtja.com");
		tykLoginUserName.setPath("/");
		cookieStroe.addCookie(tykLoginUserName);
		BasicClientCookie checksavetykLoginUserName = new BasicClientCookie(
				"checksavetykLoginUserName", "0");
		checksavetykLoginUserName.setDomain("www.gtja.com");
		checksavetykLoginUserName.setPath("/");
		cookieStroe.addCookie(checksavetykLoginUserName);

		ResponseHandler<JSONObject> jrh = new JSONObjectResponseHandler();
		String currentToken = null;
		try {
			JSONObject json = httpclient.execute(loginPost, jrh, localContext);
			log.debug(currentToken);
			currentToken = json.get("currentToken").toString();

			cookieDisplay(cookieStroe);

		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		} finally {
			loginPost.abort();
		}
		return currentToken;
	}

	/**
	 * @return
	 * 
	 */
	private static String getChkImage() {
		HttpGet httpget = new HttpGet(
				"http://www.gtja.com/share/verifyCodeWhite.jsp");

		ResponseHandler<String> irh = new ImageResponseHandler();
		String imgPath = null;
		try {
			imgPath = httpclient.execute(httpget, irh, localContext);
			cookieDisplay(cookieStroe);
		} catch (ClientProtocolException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		} finally {
			httpget.abort();
		}

		log.debug("请打开" + imgPath + "，并且在这里输入其中的字符串，然后回车：");
		InputStreamReader isr = new InputStreamReader(System.in);
		BufferedReader br = new BufferedReader(isr);
		String check = null;
		try {
			check = br.readLine();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return check;
	}

	private static Document getText(String url) {
		HttpGet httpget = new HttpGet(url);

		ResponseHandler<Document> jrh = new JsoupResponseHandler();
		Document page = null;
		try {
			page = httpclient.execute(httpget, jrh, localContext);
			cookieDisplay(cookieStroe);
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			httpget.abort();
		}
		return page;
	}

	/**
	 * @param cookieStroe
	 */
	private static void cookieDisplay(CookieStore cookieStroe) {
		List<Cookie> cookies = cookieStroe.getCookies();
		for (Cookie cookie : cookies) {
			log.debug(">>>" + cookie.getName() + " : " + cookie.getValue()
					+ " | " + cookie.getDomain());
		}
	}
}
