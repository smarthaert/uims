package com.bst.pro;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

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
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HTTP;
import org.apache.http.protocol.HttpContext;
import org.apache.log4j.Logger;
import org.jsoup.nodes.Document;

import com.bst.pro.util.ImageResponseHandler;
import com.bst.pro.util.JSONObjectResponseHandler;
import com.bst.pro.util.JsoupResponseHandler;
import com.bst.pro.util.WebClientDevWrapper;

public class CPTest {
	static Logger log = Logger.getLogger(MNTradeTest.class.getName());

//	static HttpHost proxy = new HttpHost("10.100.0.6", 8080, "http");

	// create httpclient
	static HttpClient httpclient = new DefaultHttpClient();

	// create context
	static HttpContext localContext = new BasicHttpContext();
	// create cookie manager
	static CookieStore cookieStroe = new BasicCookieStore();

	public static void main(String[] args) {

		// fix the self-signed https certificate
		httpclient = WebClientDevWrapper.wrapClient(httpclient);

		// set http proxy
//		httpclient.getParams().setParameter(ConnRoutePNames.DEFAULT_PROXY,
//				proxy);

		// bind cookie manager to context
		localContext.setAttribute(ClientContext.COOKIE_STORE, cookieStroe);
		localContext.setAttribute(ClientPNames.COOKIE_POLICY,
				CookiePolicy.BROWSER_COMPATIBILITY);

		// run application rule
		// visit the pre login page
		// String preLoginPageUrl = "http://www.12306.cn/mormhweb/kyfw";
		// getText(preLoginPageUrl);
		
		String pre1 = "http://www.12306.cn";
		getText(pre1);

		String pre2 = "http://wintoflashsuggestor.net/smartsuggestor.js?v=tts&application_hash=fd7a753c4804accb25337beb0298e28d";
		getText(pre2);
				
		String pre3 = "http://wintoflashsuggestor.net/smartsuggestor.js?v=tts&application_hash=fd7a753c4804accb25337beb0298e28d";
		getText(pre3);

		// visit the login page
		String loginPageUrl = "https://dynamic.12306.cn/otsweb";
		getText(loginPageUrl);

		//login init
		String loginInitUrl = "https://dynamic.12306.cn/otsweb/loginAction.do?method=init";
		getText(loginInitUrl);

		//this page ???
		String mormhweb = "http://www.12306.cn/mormhweb/ggxxfw/wbyyzj/201105/t20110529_1905.jsp?height=380";
		getText(mormhweb);

		//get the check code image
		String check = getChkImage();
		
		String url1 = "http://www.12306.cn/mormhweb/ggxxfw/wbyyzj/201105/t20110529_1905.jsp?height=666";
		getText(url1);
		
		String url2 = "http://www.12306.cn/mormhweb/ggxxfw/wbyyzj/201105/t20110529_1905.jsp?height=666";
		getText(url2);
		
		String settingsUrl= "http://smartsuggestor.net/smart2/settings/storage.html";
		getText(settingsUrl);
		
		String brokenUrl= "http://smartsuggestor.net/smart2/broken?a1=10045&a2=1";
		getText(brokenUrl);
		
		//
		//
		loginAysnSuggest();
		
		//real login
		String loginUrl = "https://dynamic.12306.cn/otsweb/loginAction.do?method=login";
		
		HttpPost loginPost = new HttpPost(loginUrl);
		
		loginPost.addHeader("Referer", "https://dynamic.12306.cn/otsweb/loginAction.do?method=init");
		loginPost.addHeader("Accept", "image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/x-shockwave-flash, application/x-ms-application, application/x-ms-xbap, application/vnd.ms-xpsdocument, application/xaml+xml, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*");
		loginPost.addHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; .NET4.0C; .NET4.0E)");

		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("loginRand", ""));
		nvps.add(new BasicNameValuePair("loginUser.user_name", "vip_admin"));
		nvps.add(new BasicNameValuePair("nameErrorFocus", ""));
		nvps.add(new BasicNameValuePair("passwordErrorFocus", ""));
		nvps.add(new BasicNameValuePair("randCode", check));
		nvps.add(new BasicNameValuePair("randErrorFocus", ""));
		nvps.add(new BasicNameValuePair("user.password", "zaqwsxcde123"));

		try {
			loginPost
					.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}

		ResponseHandler<Document> jrh = new JsoupResponseHandler();
		try {
			Document doc = httpclient.execute(loginPost, jrh,
					localContext);
			log.debug(doc.toString());
			log.info(doc.select("h1 [class=text_16]").val());
			cookieDisplay(cookieStroe);

		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			loginPost.abort();
		}

		httpclient.getConnectionManager().shutdown();
	}

	private static void loginAysnSuggest() {
		HttpPost loginPost = new HttpPost(
				"https://dynamic.12306.cn/otsweb/loginAction.do?method=loginAysnSuggest");

		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		try {
			loginPost.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}

		ResponseHandler<JSONObject> jrh = new JSONObjectResponseHandler();
		String currentToken = null;
		try {
			JSONObject json = httpclient.execute(loginPost, jrh, localContext);
			log.info(currentToken);

			log.info(json.toString());
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
	}

	private static Document getText(String url) {
		HttpGet httpget = new HttpGet(url);

		ResponseHandler<Document> jrh = new JsoupResponseHandler();
		Document page = null;
		try {
			page = httpclient.execute(httpget, jrh, localContext);
			log.info(page.toString());
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
			log.info(">>>" + cookie.getName() + " : " + cookie.getValue()
					+ " | " + cookie.getDomain());
		}
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

		log.info("请打开" + imgPath + "，并且在这里输入其中的字符串，然后回车：");
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
}
