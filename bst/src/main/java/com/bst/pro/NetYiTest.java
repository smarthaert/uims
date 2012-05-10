package com.bst.pro;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;

public class NetYiTest {
	static HttpClient httpclient = new DefaultHttpClient();
	
	private static String netyiUrlloginFp = "http://www.netyi.net/controls/loginFp.aspx";
	private static String netyiUrlloginSu = "http://www.netyi.net/controls/loginSu.aspx";
	
	public static void main(String[] args) {
		Map<String, String> serverData = getPrePostData();
		
		Map<String, String> userData = new HashMap<String, String>();
		userData.put("tbMemberName", "tttttttt001");
		userData.put("tbPassword", "tttttttt001");
		
		//构造Post数据
		login(serverData, userData);
		
	}

	private static void login(Map<String, String> preData, Map<String, String> userData) {
		preData.putAll(userData);
		
		System.out.println(preData);
		
		String pageCont = postText(netyiUrlloginSu, preData);
		System.out.println(pageCont);
	}
	
	private static String postText(String url, Map<String, String> values) {
		HttpPost httppost = new HttpPost(url);
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		for (Map.Entry<String, String> e : values.entrySet()) {
			nvps.add(new BasicNameValuePair(e.getKey(), e.getValue()));
		}
		// Create a response handler
		ResponseHandler<String> responseHandler = new BasicResponseHandler();
		String responseBody = "";
		try {
			httppost.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));
			responseBody = httpclient.execute(httppost, responseHandler);
		} catch (Exception e) {
			e.printStackTrace();
			responseBody = null;
		} finally {
			httppost.abort();
			// httpclient.getConnectionManager().shutdown();
		}
		return responseBody;
	}

	private static Map<String, String> getPrePostData() {
		// 从loginFp页面获得Post表单数据
		String pageCont = getText(netyiUrlloginFp);
		String value = null;
		int start = pageCont.indexOf("id=\"__VIEWSTATE\"");
		if(start > 0){
			int add1 = pageCont.indexOf("value=", start);
			int add2 = pageCont.indexOf("\"", add1);
			int add3 = pageCont.indexOf("\"", add2+1);
			value =pageCont.substring(add2+1, add3);
		}
		/*
		if(start != -1){
			int sta1 = pageCont.indexOf("\"", start);
			if(sta1 != -1){
				int sta2 = pageCont.indexOf("\"", sta1);
				if(sta2 != -1){
					int sta3 = pageCont.indexOf("\"", sta2);
					if(sta3 != -1){
						int sta4 = pageCont.indexOf("\"", sta3);
						value = pageCont.substring(sta3, sta4);
					}
				}
			}
		}*/
		Map<String, String> map = new HashMap<String, String>();
		map.put("__EVENTTARGET", "");
		map.put("__EVENTARGUMENT", "");
		map.put("__VIEWSTATE", value);
		map.put("btnLogin.x", "25");
		map.put("btnLogin.y", "21");
		return map;
	}

	private static String getText(String redirectLocation) {
		
		HttpGet httpget = new HttpGet(redirectLocation);
		// Create a response handler
		ResponseHandler<String> responseHandler = new BasicResponseHandler();
		String responseBody = "";
		try {
			responseBody = httpclient.execute(httpget, responseHandler);
		} catch (Exception e) {
			e.printStackTrace();
			responseBody = null;
		} finally {
			httpget.abort();
			// httpclient.getConnectionManager().shutdown();
		}
		return responseBody;
	}
}
