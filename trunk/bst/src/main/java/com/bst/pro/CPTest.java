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
import org.apache.http.HttpRequest;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.ProtocolException;
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
import org.apache.http.impl.client.DefaultRedirectStrategy;
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

	static HttpHost proxy = new HttpHost("10.100.0.6", 8080, "http");

	// create httpclient
	static HttpClient httpclient = new DefaultHttpClient();

	// create context
	static HttpContext localContext = new BasicHttpContext();
	// create cookie manager
	static CookieStore cookieStroe = new BasicCookieStore();

	public static void main(String[] args) {

		// fix the self-signed https certificate
		httpclient = WebClientDevWrapper.wrapClient(httpclient);

		//handle 301 and 302 redirect
		((DefaultHttpClient)httpclient).setRedirectStrategy(new DefaultRedirectStrategy() {
			public boolean isRedirected(HttpRequest request,
					HttpResponse response, HttpContext context) {
				boolean isRedirect = false;
				try {
					isRedirect = super.isRedirected(request, response, context);
				} catch (ProtocolException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				if (!isRedirect) {
					int responseCode = response.getStatusLine().getStatusCode();
					if (responseCode == 301 || responseCode == 302) {
						return true;
					}
				}
				return isRedirect;
			}
		});
		
		// set http proxy
		httpclient.getParams().setParameter(ConnRoutePNames.DEFAULT_PROXY,
				proxy);

		// bind cookie manager to context
		localContext.setAttribute(ClientContext.COOKIE_STORE, cookieStroe);
		localContext.setAttribute(ClientPNames.COOKIE_POLICY,
				CookiePolicy.BROWSER_COMPATIBILITY);


		// visit the login page
		String loginPageUrl = "https://dynamic.12306.cn/otsweb";
		getText(loginPageUrl);

		//login init
		String loginInitUrl = "https://dynamic.12306.cn/otsweb/loginAction.do?method=init";
		getText(loginInitUrl);

		//get the check code image
		String check = getChkImage();
		
		//
		loginAysnSuggest();
		
		//real login
		String loginUrl = "https://dynamic.12306.cn/otsweb/loginAction.do?method=login";
		realLoginPost(check, loginUrl);
		
		String queryInitUrl = "https://dynamic.12306.cn/otsweb/order/querySingleAction.do?method=init";
		getText(queryInitUrl);
		
		//query the ticket info
		String queryTicketUrl = "https://dynamic.12306.cn/otsweb/order/querySingleAction.do?method=queryLeftTicket" +
				"&orderRequest.train_date=2012-05-16" +
				"&orderRequest.from_station_telecode=SHH" +
				"&orderRequest.to_station_telecode=HFH" +
				"&orderRequest.train_no=" +
				"&trainPassType=QB" +
				"&trainClass=QB%23D%23Z%23T%23K%23QT%23" +
				"&includeStudent=00" +
				"&seatTypeAndNum=" +
				"&orderRequest.start_time_str=00%3A00--24%3A00";
		getText(queryTicketUrl);
		
		//submit order
		String submitOrderUrl = "https://dynamic.12306.cn/otsweb/order/querySingleAction.do?method=submutOrderRequest";
			
		HttpPost submitOrderPost = new HttpPost(loginUrl);
		
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("arrive_time", "16:54"));
		nvps.add(new BasicNameValuePair("from_station_name", "上海虹桥"));
		nvps.add(new BasicNameValuePair("from_station_telecode", "AOH")); //出发地代码
		nvps.add(new BasicNameValuePair("from_station_telecode_name", "上海"));
		nvps.add(new BasicNameValuePair("include_student", "0"));//是否包含学生票
		nvps.add(new BasicNameValuePair("lishi", "3:27"));//具体车次的值
		nvps.add(new BasicNameValuePair("mmStr", "75BCEA13B77FF7502F096F13D24D24E3E3CDA2CA1A6254BE1D35760B"));//
		nvps.add(new BasicNameValuePair("round_start_time_str", "00:00--24:00"));
		nvps.add(new BasicNameValuePair("round_train_date", "2012-5-16"));
		nvps.add(new BasicNameValuePair("seattype_num", ""));
		nvps.add(new BasicNameValuePair("single_round_type", "1"));
		nvps.add(new BasicNameValuePair("start_time_str", "00:00--24:00"));
		nvps.add(new BasicNameValuePair("station_train_code", "D3026"));//车次
		nvps.add(new BasicNameValuePair("to_station_name", "合肥"));
		nvps.add(new BasicNameValuePair("to_station_telecode", "HFH"));
		nvps.add(new BasicNameValuePair("to_station_telecode_name", "合肥"));
		nvps.add(new BasicNameValuePair("train_class_arr", "QB#D#Z#T#K#QT#"));//列车类别，为多选框，#号分隔
		nvps.add(new BasicNameValuePair("train_date", "2012-5-16"));
		nvps.add(new BasicNameValuePair("train_pass_type", "QB"));//路过的类型
		nvps.add(new BasicNameValuePair("train_start_time", "13:27"));
		nvps.add(new BasicNameValuePair("trainno3", "5l000D302611")); //
		nvps.add(new BasicNameValuePair("ypInfoDetail", "M018900000O015700000O015703004"));//
						
		try {
			submitOrderPost
					.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}

		ResponseHandler<String> brh = new BasicResponseHandler();
		try {
			String responseBody = httpclient.execute(submitOrderPost, brh, localContext);
			log.debug(responseBody);
			cookieDisplay(cookieStroe);

		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			submitOrderPost.abort();
		}
		
		String confirmUrl = "https://dynamic.12306.cn/otsweb/order/confirmPassengerAction.do?method=init";
		getText(confirmUrl);

		httpclient.getConnectionManager().shutdown();
	}

	private static void realLoginPost(String check, String loginUrl) {
		HttpPost loginPost = new HttpPost(loginUrl);
		
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
				"https://dynamic.12306.cn/otsweb/passCodeAction.do?rand=lrand");

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
