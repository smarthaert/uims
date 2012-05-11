package com.bst.pro;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpHost;
import org.apache.http.NameValuePair;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.params.ClientPNames;
import org.apache.http.client.params.CookiePolicy;
import org.apache.http.client.utils.URIUtils;
import org.apache.http.client.utils.URLEncodedUtils;
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

public class WebFXTest {

	static DefaultHttpClient httpclient = new DefaultHttpClient();
	static HttpContext localContext = new BasicHttpContext();
	static BasicCookieStore bcs = new BasicCookieStore();

	public static void main(String[] args) {
		HttpHost proxy = new HttpHost("10.100.0.6",8080,"http");
		httpclient.getParams().setParameter(ConnRoutePNames.DEFAULT_PROXY, proxy);

		httpclient.getParams().setParameter(ClientPNames.COOKIE_POLICY, CookiePolicy.BROWSER_COMPATIBILITY);
		
		//http://webim.feixin.10086.cn/
		//IsCookiesEnable	Received	true	/	webim.feixin.10086.cn	(Session)	Server	No	No
		
		//https://webim.feixin.10086.cn/login.aspx
		String loginUrl = "https://webim.feixin.10086.cn/login.aspx";
		BasicClientCookie bcc = new BasicClientCookie("IsCookiesEnable", "true");
		bcc.setDomain("webim.feixin.10086.cn");
		bcc.setPath("/");
		bcs.addCookie(bcc);
		String context = getText(loginUrl);
//		System.out.println(context);
		List<Cookie> cookies = bcs.getCookies();
		for(Cookie cookie : cookies){
			System.out.println(cookie.toString());
		}
	
		//https://webim.feixin.10086.cn/login.aspx
			//IsCookiesEnable	Sent	true	/	webim.feixin.10086.cn	(Session)	Server	No	No
		String checkImgUrl = "https://webim.feixin.10086.cn/WebIM/GetPicCode.aspx";
		BasicClientCookie ccpsession = new BasicClientCookie("ccpsession", "7f671465-95b6-47e9-a3b5-1d23ce8e0698");
		bcc.setDomain(".webim.feixin.10086.cn");
		bcc.setPath("/");
		bcs.addCookie(ccpsession);
		
		BasicClientCookie IsCookiesEnable = new BasicClientCookie("IsCookiesEnable", "true");
		bcc.setDomain(".webim.feixin.10086.cn");
		bcc.setPath("/");
		bcs.addCookie(IsCookiesEnable);
		
		List<NameValuePair> qparams = new ArrayList<NameValuePair>();
		qparams.add(new BasicNameValuePair("",""));
		qparams.add(new BasicNameValuePair("",""));
		try {
			URI uri = URIUtils.createURI("https", "webim.feixin.10086.cn", 443, "WebIM/GetPicCode.aspx", URLEncodedUtils.format(qparams, "UTF-8"), null);
		} catch (URISyntaxException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String imgPath = getCheckImage(checkImgUrl);  
		BasicClientCookie webim_loginCounter = new BasicClientCookie("webim_loginCounter", "1336726000812");
		bcc.setDomain(".webim.feixin.10086.cn");
		bcc.setPath("/");
		bcs.addCookie(webim_loginCounter);
		
		System.out.println("请打开"+imgPath+"，并且在这里输入其中的字符串，然后回车：");
        InputStreamReader ins = new InputStreamReader(System.in);  
        BufferedReader br = new BufferedReader(ins);  
        String check = null;
        try {
			check = br.readLine();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}    
		//https://webim.feixin.10086.cn/WebIM/GetPicCode.aspx?Type=ccpsession&0.8241476046703796
			//0.8241476046703796	
			//Type	ccpsession
			//ccpsession	Sent	7f671465-95b6-47e9-a3b5-1d23ce8e0698	/	.webim.feixin.10086.cn	(Session)	Server	No	No
			//ccpsession	Received	e3dc3b96-cd6b-41dc-b98e-13d032b64265	/	.webim.feixin.10086.cn	(Session)	Server	No	No
			//IsCookiesEnable	Sent	true	/	.webim.feixin.10086.cn	(Session)	Server	No	No
			//webim_loginCounter	Sent	1336726000812	/	.webim.feixin.10086.cn	Fri, 11 May 2012 08:46:40 UTC	JavaScript	No	No

			
		//https://webim.feixin.10086.cn/WebIM/Login.aspx
			//Ccp	jmdk	8	
			//OnlineStatus	400	16	
			//Pwd	my156004	12	
			//UserName	13611913741	20	
		
		//https://webim.feixin.10086.cn/SetCounter.aspx?Version=1&coutertype=500300001,500200016,500800002&tag=default&val=1&rand=0.5356358343101127
			//coutertype	500300001,500200016,500800002
			//rand	0.5356358343101127
			//tag	default
			//val	1
			//Version	1
		
		//https://webim.feixin.10086.cn/main.aspx
			
		//https://webim.feixin.10086.cn/WebIM/GetPersonalInfo.aspx?Version=0
			//Version	0
			//POST
			//222857364p20172-e2e5bf9b-b9db-413b-a2ed-a29bae92c747
		//https://webim.feixin.10086.cn/WebIM/GetCred.aspx?Version=1
			//Version	1
			//POST
			//222857364p20172-e2e5bf9b-b9db-413b-a2ed-a29bae92c747
		//https://webim.feixin.10086.cn/WebIM/GetGroupList.aspx?Version=2
			//Version	2
			//POST
			//222857364p20172-e2e5bf9b-b9db-413b-a2ed-a29bae92c747
		//https://webim.feixin.10086.cn/WebIM/GetPortrait.aspx?did=222857364&Size=3&Crc=-1517160110&mid=222857364
			//Crc	-1517160110
			//did	222857364
			//mid	222857364
			//Size	3
		//https://webim.feixin.10086.cn/WebIM/GetContactList.aspx?Version=3
			//Version	3
			//POST
			//222857364p20172-e2e5bf9b-b9db-413b-a2ed-a29bae92c747
		//https://webim.feixin.10086.cn/WebIM/GetConnect.aspx?Version=4
			//Version	4
			//POST
			//reported		9	
			//ssid	222857364p20172-e2e5bf9b-b9db-413b-a2ed-a29bae92c747	57	
		//https://webim.feixin.10086.cn/WebIM/GetConnect.aspx?Version=5
			//Version	5
			//POST
			//reported		9	
			//ssid	222857364p20172-e2e5bf9b-b9db-413b-a2ed-a29bae92c747	57	
		
		//https://webim.feixin.10086.cn/content/WebIM/SendSMS.aspx?Version=6
			//Version	6
			//POST
			//Message	test...	15	
			//Receivers	222857364	19	
			//ssid	222857364p20172-e2e5bf9b-b9db-413b-a2ed-a29bae92c747	57	
			//UserName	222857364	18	
		//https://webim.feixin.10086.cn/WebIM/GetPortrait.aspx?did=229057283&Size=5&Crc=1098269575&mid=222857364
			//Crc	1098269575
			//did	229057283
			//mid	222857364
			//Size	5
		//https://webim.feixin.10086.cn/WebIM/Logout.aspx?Version=13
			//Version	13
			//ssid	222857364p20172-e2e5bf9b-b9db-413b-a2ed-a29bae92c747	57	
		//http://feixin.10086.cn/account/loginout?ul=https://webim.feixin.10086.cn/login.aspx
			//ASP.NET_SessionId	Received	kdszw255oq4fyx55og4d31zy	/	feixin.10086.cn	(Session)	Server	Yes	No
			//webim_remindmsgs	Sent	645048052-39532%21191-0-e2e5bf9bb9db413ba2eda29bae92c747	/	.feixin.10086.cn	Thu, 10 May 2012 05:03:52 GMT	JavaScript	No	No
			//ul	https://webim.feixin.10086.cn/login.aspx
			
			//https://webim.feixin.10086.cn/login.aspx

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
	
	private static String getCheckImage(String url){  

		HttpGet httpget = new HttpGet(url);
		// Create a response handler
		ResponseHandler<String> responseHandler = new ImageResponseHandler();
		String imgPath = "";
		try {
			imgPath = httpclient.execute(httpget, responseHandler);
			System.out.println(imgPath);
		} catch (Exception e) {
			e.printStackTrace();
			imgPath = null;
		} finally {
			httpget.abort();
			// httpclient.getConnectionManager().shutdown();
		}
		return imgPath;
    }  
}
