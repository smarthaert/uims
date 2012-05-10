package com.bst.pro;

import java.util.ArrayList;
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

public class WebFXTest {

	static HttpClient httpclient = new DefaultHttpClient();

	public static void main(String[] args) {

		//http://webim.feixin.10086.cn/
		//IsCookiesEnable	Received	true	/	webim.feixin.10086.cn	(Session)	Server	No	No
		
		//https://webim.feixin.10086.cn/login.aspx
		String loginUrl = "https://webim.feixin.10086.cn/login.aspx";
		getText(loginUrl);
	
		//https://webim.feixin.10086.cn/login.aspx
			//IsCookiesEnable	Sent	true	/	webim.feixin.10086.cn	(Session)	Server	No	No
			
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
			System.out.println(responseBody);
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
}
