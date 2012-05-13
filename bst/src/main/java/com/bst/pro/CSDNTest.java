package com.bst.pro;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.List;
import java.util.logging.Logger;

import javax.imageio.ImageIO;

import org.apache.http.HeaderIterator;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.CookieStore;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.protocol.ClientContext;
import org.apache.http.cookie.Cookie;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;

import com.bst.pro.util.ImageResponseHandler;

public class CSDNTest {

	static Logger log = Logger.getLogger(CSDNTest.class.getName());

	public static void main(String[] args) {

//		basicLogin();

		cookieAutoManagerLogin();
	}

	private static void cookieAutoManagerLogin() {
		//create client
		HttpClient httpclient = new DefaultHttpClient();
		//create context 
		HttpContext localContext = new BasicHttpContext();
		//create cookie store
		CookieStore cookieStore = new BasicCookieStore();
		
		//bind the store
		localContext.setAttribute(ClientContext.COOKIE_STORE, cookieStore);

		//create request
		HttpGet chkImgGet = new HttpGet(
				"http://passport.csdn.net/ajax/verifyhandler.ashx?r=0.21973005150126756");
		
		//init cookie info
		String cookie = "__utma=17226283.649901018.1336879658.1336879658.1336879658.1; __utmb=17226283.2.10.1336879658; __utmc=17226283; __utmz=17226283.1336879658.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); __message_sys_msg_id=0; __message_gu_msg_id=0; __message_cnel_msg_id=0; __message_district_code=000000; __message_in_school=0; ";
		//add to header
		chkImgGet.addHeader("Cookie", cookie);

		
		ResponseHandler<String> imgHandler = new ImageResponseHandler();
		String check = null;
		try {
			String imgPath = httpclient.execute(chkImgGet, imgHandler,
					localContext);
			
			//print the response cookies from cookiestore
			List<Cookie> cookies = cookieStore.getCookies();
			for (Cookie c : cookies) {
				log.info("Image:>>> " + c.getName() + " : " + c.getValue());
			}
			
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

		//create login request
		HttpGet loginGet = new HttpGet(
				"http://passport.csdn.net/ajax/accounthandler.ashx?t=log&u=a_t_jamy&p=250656506&c="
						+ check
						+ "&remember=0&f=http%3A%2F%2Fpassport.csdn.net%2Faccount%2Flogin&rand=0.4073978272758557");

		ResponseHandler<String> responseHandler = new BasicResponseHandler();
		try {
			String responseBody = httpclient.execute(loginGet, responseHandler,
					localContext);
			
			List<Cookie> cookies = cookieStore.getCookies();
			for (Cookie c : cookies) {
				log.info("Login:>>> " + c.getName() + " : " + c.getValue());
			}
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
		//HTTPCLIENT 相当于浏览器
		HttpClient httpclient = new DefaultHttpClient();
		//发请求
		HttpGet httpget = new HttpGet(
				"http://passport.csdn.net/ajax/verifyhandler.ashx?r=0.21973005150126756");

		String cookie = "__utma=17226283.649901018.1336879658.1336879658.1336879658.1; __utmb=17226283.2.10.1336879658; __utmc=17226283; __utmz=17226283.1336879658.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); __message_sys_msg_id=0; __message_gu_msg_id=0; __message_cnel_msg_id=0; __message_district_code=000000; __message_in_school=0; ";
		httpget.addHeader("Cookie", cookie);
		httpget.addHeader("Accept", "image/png,image/*;q=0.8,*/*;q=0.5");
		httpget.addHeader("Accept-Charset", "GB2312,utf-8;q=0.7,*;q=0.7");
		httpget.addHeader("Referer",
				"http://passport.csdn.net/account/loginbox?callback=logined");
		httpget
				.addHeader(
						"User-Agent",
						"Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.2.28) Gecko/20120306 Firefox/3.6.28");

		HttpResponse response = null;
		try {
			response = httpclient.execute(httpget);
		} catch (ClientProtocolException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} finally {
		}

		HeaderIterator hi = response.headerIterator("Set-Cookie");
		while (hi.hasNext()) {
			String setCookie = hi.next().toString();
			// cookie += setCookie +"; ";
			log.info(setCookie);
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
		//一定记得把请求的资源释放掉
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

		HttpGet loginGet = new HttpGet(
				"http://passport.csdn.net/ajax/accounthandler.ashx?t=log&u=a_t_jamy&p=250656506&c="
						+ check
						+ "&remember=0&f=http%3A%2F%2Fpassport.csdn.net%2Faccount%2Flogin&rand=0.4073978272758557");
		httpget.addHeader("Cookie", cookie);
		httpget.addHeader("Accept", "image/png,image/*;q=0.8,*/*;q=0.5");
		httpget.addHeader("Accept-Charset", "GB2312,utf-8;q=0.7,*;q=0.7");
		httpget.addHeader("Referer",
				"http://passport.csdn.net/account/loginbox?callback=logined");
		httpget
				.addHeader(
						"User-Agent",
						"Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.2.28) Gecko/20120306 Firefox/3.6.28");

		ResponseHandler<String> responseHandler = new BasicResponseHandler();
		try {
			String responseBody = httpclient.execute(loginGet, responseHandler);
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

		//关闭浏览器
		httpclient.getConnectionManager().shutdown();
	}

	// http://passport.csdn.net/ajax/verifyhandler.ashx?r=0.21973005150126756
	// __utmc Sent 17226283 / .csdn.net (Session) JavaScript No No
	// __utmb Sent 17226283.2.10.1336879658 / .csdn.net Sun, 13 May 2012
	// 03:57:52 GMT JavaScript No No
	// __message_district_code Sent 000000 / .csdn.net Fri, 18-May-2012 03:27:48
	// GMT Stored No No
	// __message_in_school Sent 0 / .csdn.net Wed, 23-May-2012 03:27:48 GMT
	// Stored No No
	// __message_cnel_msg_id Sent 0 / .csdn.net Tue, 12-Jun-2012 03:27:48 GMT
	// Stored No No
	// __message_gu_msg_id Sent 0 / .csdn.net Tue, 12-Jun-2012 03:27:48 GMT
	// Stored No No
	// __message_sys_msg_id Sent 0 / .csdn.net Tue, 12-Jun-2012 03:27:48 GMT
	// Stored No No
	// __utmz Sent
	// 17226283.1336879658.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none) /
	// .csdn.net Sun, 11 Nov 2012 15:27:52 GMT JavaScript No No
	// __utma Sent 17226283.649901018.1336879658.1336879658.1336879658.1 /
	// .csdn.net Tue, 13 May 2014 03:27:52 GMT JavaScript No No
	// pp_vc Received 7jGN3GgLkLksb43qpP1A4qfZxZM3HJJiI1V3lIYn2eA= /
	// passport.csdn.net Sun, 13-May-2012 04:24:11 GMT Server No No

	// 图片

	// http://passport.csdn.net/ajax/accounthandler.ashx?t=log&u=a_t_jamy&p=12442835&c=5gbc5&remember=0&f=http%3A%2F%2Fpassport.csdn.net%2Faccount%2Flogin&rand=0.4073978272758557
	// __message_cnel_msg_id Sent 0 / .csdn.net Tue, 12-Jun-2012 03:27:48 GMT
	// Stored No No
	// __message_district_code Sent 000000 / .csdn.net Fri, 18-May-2012 03:27:48
	// GMT Stored No No
	// __message_gu_msg_id Sent 0 / .csdn.net Tue, 12-Jun-2012 03:27:48 GMT
	// Stored No No
	// __message_in_school Sent 0 / .csdn.net Wed, 23-May-2012 03:27:48 GMT
	// Stored No No
	// __message_sys_msg_id Sent 0 / .csdn.net Tue, 12-Jun-2012 03:27:48 GMT
	// Stored No No
	// __utma Sent 17226283.649901018.1336879658.1336879658.1336879658.1 /
	// .csdn.net Tue, 13 May 2014 03:27:52 GMT JavaScript No No
	// __utmb Sent 17226283.2.10.1336879658 / .csdn.net Sun, 13 May 2012
	// 03:57:52 GMT JavaScript No No
	// __utmc Sent 17226283 / .csdn.net (Session) JavaScript No No
	// __utmz Sent
	// 17226283.1336879658.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none) /
	// .csdn.net Sun, 11 Nov 2012 15:27:52 GMT JavaScript No No
	// pp_vc Sent 7jGN3GgLkLksb43qpP1A4qfZxZM3HJJiI1V3lIYn2eA= /
	// passport.csdn.net Sun, 13-May-2012 04:24:11 GMT Server No No

	// c 5gbc5
	// f http://passport.csdn.net/account/login
	// p 12442835
	// rand 0.4073978272758557
	// remember 0
	// t log
	// u a_t_jamy

	// {"status":true,"error":"","data":{"userId":976512,"userName":"A_T_Jamy","password":"b22ad3b7117294401129cd2f6e18f93f","email":"a.t.jamy@163.com","lastLoginTime":"2012-05-13 11:24:56","loginTimes":63,"lastLoginIP":"101.80.58.14","isDeleted":false,"registerIP":"","registerTime":"2005-03-19 03:14:00","isActived":true,"role":0,"isLocked":false}}
}
