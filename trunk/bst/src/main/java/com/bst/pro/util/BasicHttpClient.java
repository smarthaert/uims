package com.bst.pro.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONException;

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
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HTTP;
import org.apache.http.protocol.HttpContext;
import org.apache.log4j.Logger;
import org.jsoup.nodes.Document;

public class BasicHttpClient {
	static Logger log = Logger.getLogger(BasicHttpClient.class.getName());

	// create httpclient
	static HttpClient httpclient = new DefaultHttpClient();
	// create context
	static HttpContext localContext = new BasicHttpContext();
	// create cookie manager
	static CookieStore cookieStroe = new BasicCookieStore();

	/**
	 * 使用本地cookie管理
	 */
	protected static void setLocalCookieManger() {
		// bind cookie manager to context
		localContext.setAttribute(ClientContext.COOKIE_STORE, cookieStroe);
		localContext.setAttribute(ClientPNames.COOKIE_POLICY,
				CookiePolicy.BROWSER_COMPATIBILITY);
	}

	/**
	 * 设置代理
	 * @param proxyHost
	 * @param proxyPort
	 * @param proxyScheme
	 */
	protected static void setProxy(String proxyHost, int proxyPort,
			String proxyScheme) {
		HttpHost proxy = new HttpHost(proxyHost, proxyPort, proxyScheme);
		// set http proxy
		httpclient.getParams().setParameter(ConnRoutePNames.DEFAULT_PROXY,
				proxy);
	}

	/**
	 * 不带参数的post请求
	 * @param queryStr
	 */
	protected static void postText(String queryStr) {
		HttpPost loginPost = new HttpPost(queryStr);

		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		try {
			loginPost.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}

		ResponseHandler<String> brh = new BasicResponseHandler();
		try {
			String responseBody = httpclient.execute(loginPost, brh,
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
	}

	/**
	 * 获取验证码并提示用户输入
	 * @return
	 * 
	 */
	protected static String getChkImage(String imgUrl) {
		HttpGet httpget = new HttpGet(imgUrl);

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

	/**
	 * 发送get请求并解析得到的页面为Document对象
	 * @param url
	 * @return
	 */
	protected static Document getText(String url) {
		HttpGet httpget = new HttpGet(url);

		ResponseHandler<Document> jrh = new JsoupResponseHandler();
		Document page = null;
		try {
			page = httpclient.execute(httpget, jrh, localContext);
			log.debug(page.toString());
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
	 * 显示本地Cookie库中的内容
	 * @param cookieStroe
	 */
	protected static void cookieDisplay(CookieStore cookieStroe) {
		List<Cookie> cookies = cookieStroe.getCookies();
		for (Cookie cookie : cookies) {
			log.info(">>>" + cookie.getName() + " : " + cookie.getValue()
					+ " | " + cookie.getDomain());
		}
	}
}
