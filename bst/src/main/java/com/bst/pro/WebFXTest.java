package com.bst.pro;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.imageio.ImageIO;

import org.apache.http.HeaderIterator;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.CookieStore;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.protocol.ClientContext;
import org.apache.http.cookie.Cookie;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HTTP;
import org.apache.http.protocol.HttpContext;

import com.bst.pro.util.ImageResponseHandler;

public class WebFXTest {

	static Logger log = Logger.getLogger(WebFXTest.class.getName());

	public static void main(String[] args) {

		basicLogin();

		// cookieAutoManagerLogin();
	}

	private static void cookieAutoManagerLogin() {
		HttpClient httpclient = new DefaultHttpClient();
		HttpContext localContext = new BasicHttpContext();
		CookieStore cookieStore = new BasicCookieStore();
		localContext.setAttribute(ClientContext.COOKIE_STORE, cookieStore);

		HttpGet chkImgGet = new HttpGet(
				"http://passport.csdn.net/ajax/verifyhandler.ashx?r=0.21973005150126756");
		String cookie = "__utma=17226283.649901018.1336879658.1336879658.1336879658.1; __utmb=17226283.2.10.1336879658; __utmc=17226283; __utmz=17226283.1336879658.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); __message_sys_msg_id=0; __message_gu_msg_id=0; __message_cnel_msg_id=0; __message_district_code=000000; __message_in_school=0; ";
		chkImgGet.addHeader("Cookie", cookie);

		ResponseHandler<String> imgHandler = new ImageResponseHandler();
		String check = null;
		try {
			String imgPath = httpclient.execute(chkImgGet, imgHandler,
					localContext);
			log.info("请打开" + imgPath + "，并且在这里输入其中的字符串，然后回车：");
			InputStreamReader ins = new InputStreamReader(System.in);
			BufferedReader br = new BufferedReader(ins);
			check = br.readLine();

		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			chkImgGet.abort();
		}

		List<Cookie> cookies = cookieStore.getCookies();
		for (Cookie c : cookies) {
			log.info(c.getName() + " : " + c.getValue());
		}

		HttpGet loginGet = new HttpGet(
				"http://passport.csdn.net/ajax/accounthandler.ashx?t=log&u=a_t_jamy&p=250656506&c="
						+ check
						+ "&remember=0&f=http%3A%2F%2Fpassport.csdn.net%2Faccount%2Flogin&rand=0.4073978272758557");

		ResponseHandler<String> responseHandler = new BasicResponseHandler();
		try {
			String responseBody = httpclient.execute(loginGet, responseHandler,
					localContext);
			log.info(responseBody);
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			loginGet.abort();
		}

		httpclient.getConnectionManager().shutdown();
	}

	/**
	 * 
	 */
	private static void basicLogin() {
		HttpClient httpclient = new DefaultHttpClient();
		HttpGet httpget = new HttpGet(
				"https://webim.feixin.10086.cn/WebIM/GetPicCode.aspx?Type=ccpsession&0.6949566061972312");

		String cookie = "webim_loginCounter=1336800284234; IsCookiesEnable=true; ";
		httpget.addHeader("Cookie", cookie);
		httpget.addHeader("Accept", "*/*");
		httpget.addHeader("Accept-Encoding", "gzip, deflate");
		httpget
				.addHeader("Referer",
						"https://webim.feixin.10086.cn/login.aspx");
		httpget
				.addHeader(
						"User-Agent",
						"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET4.0C; .NET4.0E; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)");

		HttpResponse response = null;
		try {
			response = httpclient.execute(httpget);
			HeaderIterator hi = response.headerIterator("Set-Cookie");
			while (hi.hasNext()) {
				String setCookie = hi.next().toString();
				// get the cookie from the string
				setCookie = setCookie.substring(setCookie.indexOf(":") + 1);
				setCookie = setCookie.substring(1, setCookie.indexOf(";"));
				cookie += setCookie + "; ";
				log.info(setCookie);
			}
		} catch (ClientProtocolException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} finally {
		}

		InputStream ins = null;
		try {
			ins = response.getEntity().getContent();
		} catch (IllegalStateException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		BufferedImage bi = null;
		try {
			bi = ImageIO.read(ins);
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		File file = new File("qqimg.jpg");
		try {
			ImageIO.write(bi, "jpg", file);
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		httpget.abort();

		String imgPath = file.getAbsolutePath();

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

		// HttpGet loginGet = new
		// HttpGet("http://passport.csdn.net/ajax/accounthandler.ashx?t=log&u=a_t_jamy&p=250656506&c="
		// +
		// check +
		// "&remember=0&f=http%3A%2F%2Fpassport.csdn.net%2Faccount%2Flogin&rand=0.4073978272758557");
		HttpPost loginPost = new HttpPost(
				"https://webim.feixin.10086.cn/WebIM/Login.aspx");

		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("Ccp", check));
		nvps.add(new BasicNameValuePair("OnlineStatus", "400"));
		nvps.add(new BasicNameValuePair("Pwd", "my156004"));
		nvps.add(new BasicNameValuePair("UserName", "13611913741"));
		try {
			loginPost.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		loginPost.addHeader("Cookie", cookie);
		loginPost.addHeader("Accept", "application/json, text/javascript, */*");
		loginPost.addHeader("Accept-Encoding", "gzip, deflate");
		loginPost.addHeader("Referer",
				"https://webim.feixin.10086.cn/login.aspx");
		loginPost
				.addHeader(
						"User-Agent",
						"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET4.0C; .NET4.0E; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)");

		String ssid = null;
		try {
			HttpResponse postResponse = httpclient.execute(loginPost);
			log.info(postResponse.getEntity().getContent().toString());
			HeaderIterator postHi = postResponse.headerIterator("Set-Cookie");
			while (postHi.hasNext()) {
				String setCookie = postHi.next().toString();
				// get the cookie from the string
				setCookie = setCookie.substring(setCookie.indexOf(":") + 1);
				setCookie = setCookie.substring(1, setCookie.indexOf(";"));
				// get ssid
				if (setCookie.contains("webim_sessionid")) {
					ssid = setCookie.substring(setCookie.indexOf("=") + 1,
							setCookie.length());
				}
				log.info(setCookie);
			}
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			loginPost.abort();
		}

		HttpPost smPost = new HttpPost(
				"https://webim.feixin.10086.cn/WebIM/SendMsg.aspx?Version=1");

		nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("IsSendSms", "0"));
		nvps.add(new BasicNameValuePair("msg", "今天外面在下雨哦。"));
		nvps.add(new BasicNameValuePair("ssid", ssid));
		nvps.add(new BasicNameValuePair("To", "888983017"));
		try {
			smPost.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		smPost.addHeader("Cookie", cookie);
		smPost.addHeader("Accept", "application/json, text/javascript, */*");
		smPost.addHeader("Accept-Encoding", "gzip, deflate");
		smPost.addHeader("Referer", "https://webim.feixin.10086.cn/login.aspx");
		smPost
				.addHeader(
						"User-Agent",
						"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET4.0C; .NET4.0E; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)");

		try {
			HttpResponse smResponse = httpclient.execute(smPost);
			log.info(smResponse.getEntity().getContent().toString());
			HeaderIterator postHi = smResponse.headerIterator("Set-Cookie");
			while (postHi.hasNext()) {
				String setCookie = postHi.next().toString();
				// get the cookie from the string
				setCookie = setCookie.substring(setCookie.indexOf(":") + 1);
				setCookie = setCookie.substring(1, setCookie.indexOf(";"));
				log.info(setCookie);
			}
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			smPost.abort();
		}

		smPost = new HttpPost(
				"https://webim.feixin.10086.cn/WebIM/SendMsg.aspx?Version=2");

		nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("IsSendSms", "0"));
		nvps.add(new BasicNameValuePair("msg", "加油～加油～！。"));
		nvps.add(new BasicNameValuePair("ssid", ssid));
		nvps.add(new BasicNameValuePair("To", "888983017"));
		try {
			smPost.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		smPost.addHeader("Cookie", cookie);
		smPost.addHeader("Accept", "application/json, text/javascript, */*");
		smPost.addHeader("Accept-Encoding", "gzip, deflate");
		smPost.addHeader("Referer", "https://webim.feixin.10086.cn/login.aspx");
		smPost
				.addHeader(
						"User-Agent",
						"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET4.0C; .NET4.0E; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)");

		try {
			HttpResponse smResponse = httpclient.execute(smPost);
			log.info(smResponse.getEntity().getContent().toString());
			HeaderIterator postHi = smResponse.headerIterator("Set-Cookie");
			while (postHi.hasNext()) {
				String setCookie = postHi.next().toString();
				// get the cookie from the string
				setCookie = setCookie.substring(setCookie.indexOf(":") + 1);
				setCookie = setCookie.substring(1, setCookie.indexOf(";"));
				log.info(setCookie);
			}
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			smPost.abort();
		}

		httpclient.getConnectionManager().shutdown();
	}
}
