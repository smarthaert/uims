package com.bst.pro;

import static java.util.concurrent.TimeUnit.SECONDS;
import static java.util.concurrent.TimeUnit.MINUTES;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;

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

public class FetionTest extends BasicHttpClient {

	static Logger log = Logger.getLogger(FetionTest.class.getName());

	public static void main(String[] args) {
		final Map<String, String> connConf = init();

		String userName = "13611913741";
		String pwd = "my156004";

		final String uid = "222857364"; // 3741=222857364 2333=223534907

		final String msg = "清风拂面燕杨柳～";

		login(connConf, userName, pwd);

		// 操作计数
		int version = 1;
		connConf.put("version", version + "");

		// 测试保活链接
		final ScheduledExecutorService scheduler = Executors
				.newScheduledThreadPool(2);
		final Runnable sendSMS = new Runnable() {
			int count = 0;

			public void run() {
				sendSMStoSelf(msg, uid, connConf);
			}
		};

		// 5秒钟后运行，并每隔5分钟运行一次
		final ScheduledFuture beeperHandle = scheduler.scheduleAtFixedRate(
				sendSMS, 1, 3, MINUTES);

		// 30秒后结束关闭任务，并且关闭Scheduler
		scheduler.schedule(new Runnable() {
			public void run() {
				beeperHandle.cancel(true);
				scheduler.shutdown();
				logout(connConf);

				shutdown();
			}
		}, 17, MINUTES);

	}

	public static Map<String, String> init() {
		// use proxy
		// setProxy("10.100.0.6", 8080, "http");

		setLocalCookieManger();

		Map<String, String> connConf = new HashMap<String, String>();
		return connConf;
	}

	public static void login(Map<String, String> connConf, String userName,
			String pwd) {
		String checkImgPage = "https://webim.feixin.10086.cn/WebIM/GetPicCode.aspx?Type=ccpsession&0.6949566061972312";
		String check = getChkImage(checkImgPage);
		connConf.put("check", check);

		String loginUrl = "https://webim.feixin.10086.cn/WebIM/Login.aspx";

		Map<String, String> postData = new HashMap<String, String>();
		postData.put("Ccp", check);
		postData.put("OnlineStatus", "400");
		postData.put("Pwd", pwd);
		postData.put("UserName", userName);

		postText(loginUrl, postData);

		String ssid = null;
		CookieStore cookieStroe = getCookieStroe();
		List<Cookie> cookies = cookieStroe.getCookies();
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("webim_sessionid")) {
				ssid = cookie.getValue();
				connConf.put("ssid", ssid);
				log.debug("webim_sessionid:" + ssid);
			}
		}

		String preQueryUidUrl = "https://webim.feixin.10086.cn/content/WebIM/GetPicCode.aspx?Type=addbuddy_ccpsession&0.7922769554654019";
		getText(preQueryUidUrl);
		String ccpId = null;
		String ccpsession = null;
		cookies = cookieStroe.getCookies();
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("addbuddy_ccpsession")) {
				ccpId = cookie.getValue();
				connConf.put("ccpId", ccpId);
				// cookies.remove(cookie);
				log.debug("addbuddy_ccpsession:" + ccpId);
			}
			if (cookie.getName().equals("ccpsession")) {
				ccpsession = cookie.getValue();
				// cookies.remove(cookie);
				log.debug("ccpsession:" + ccpsession);
			}
		}
	}

	public static void logout(Map<String, String> connConf) {
		int version = Integer.parseInt(connConf.get("version"));

		String logoutUrl = "https://webim.feixin.10086.cn/WebIM/Logout.aspx?Version="
				+ version++;
		Map<String, String> postData = new HashMap<String, String>();
		postData.put("ssid", connConf.get("ssid"));
		JSONObject json = postTextToJson(logoutUrl, postData);
		if (json.getString("rc").equals("200")) {
			log.debug("Logout successed");
		} else {
			log.debug("Logout failed");
		}
		connConf.put("version", version + "");
	}

	public static void sendSMS(String msg, String uid,
			Map<String, String> connConf) {
		int version = Integer.parseInt(connConf.get("version"));

		/*
		 * String queryUidUrl =
		 * "https://webim.feixin.10086.cn/content/WebIM/AddBuddy.aspx?Version="
		 * + version++; Map<String, String> postData = new HashMap<String,
		 * String>();
		 * 
		 * postData.put("AddType", "1"); postData.put("BuddyLists", "0");
		 * postData.put("Ccp", connConf.get("check")); postData.put("CcpId",
		 * connConf.get("ccpId")); postData.put("Desc", "马勇");
		 * postData.put("LocalName", null); postData.put("PhraseId", "0");
		 * postData.put("ssid", connConf.get("ssid"));
		 * postData.put("SubscribeFlag", "0"); postData.put("UserName",
		 * "13636532333");
		 * 
		 * // IsCookiesEnable Sent true / .webim.feixin.10086.cn (Session)
		 * Server No No // webim_login_status Sent 0 / .webim.feixin.10086.cn
		 * Mon, 31 Jan 2033 16:00:00 UTC JavaScript No No // webim_loginCounter
		 * Sent 1342244257406 / .webim.feixin.10086.cn Sat, 14 Jul 2012 05:37:37
		 * UTC JavaScript No No // webim_remindmsgs Sent
		 * 645048052-39532%21191-0-a56dcfc5f2c943adb168c91f6456fe59 /
		 * .feixin.10086.cn Sat, 14 Jul 2012 04:40:04 UTC JavaScript No No
		 * 
		 * //{"rc":521,"rv":{"bl":"0","bss":1,"ln":"","rs":0,"uid":223534907,"uri"
		 * :"tel:13636532333","v":"0"}} JSONObject json =
		 * postTextToJson(queryUidUrl, postData); String uid = null;
		 * if(json.getString("rc").equals("521")){ uid =
		 * json.getJSONObject("rv").getString("uid"); log.debug("uid:" + uid); }
		 */

		String sendToUrl = "https://webim.feixin.10086.cn/WebIM/SendMsg.aspx?Version="
				+ version++;

		Map<String, String> postData = new HashMap<String, String>();

		postData.put("IsSendSms", "0");
		postData.put("msg", msg);
		postData.put("ssid", connConf.get("ssid"));
		postData.put("To", uid);
		postTextToJson(sendToUrl, postData);

		connConf.put("version", version + "");

	}

	public static void sendSMStoSelf(String msg, String uid,
			Map<String, String> connConf) {
		int version = Integer.parseInt(connConf.get("version"));

		String sendToUrl = "https://webim.feixin.10086.cn/content/WebIM/SendSMS.aspx?Version="
				+ version++;

		// Message 发给自己 44
		// Receivers 222857364 19
		// ssid 222857364p20172-1bf7584d-0cd1-4dba-af1c-9ac44572c0dd 57
		// UserName 222857364 18

		// {"rc":200,"rv":{"day":986,"month":14953}}

		Map<String, String> postData = new HashMap<String, String>();

		postData.put("UserName", uid);
		postData.put("Message", msg);
		postData.put("ssid", connConf.get("ssid"));
		postData.put("Receivers", uid);
		postTextToJson(sendToUrl, postData);

		connConf.put("version", version + "");

	}

	public static int querySid(String check, String ssid, String ccpId,
			String ccpsession, int version) {
		HttpPost queryPost = new HttpPost(
				"https://webim.feixin.10086.cn/content/WebIM/AddBuddy.aspx?Version="
						+ version++);

		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("AddType", "1"));
		nvps.add(new BasicNameValuePair("BuddyLists", "0"));
		nvps.add(new BasicNameValuePair("Ccp", check));
		nvps.add(new BasicNameValuePair("CcpId", ccpId));
		nvps.add(new BasicNameValuePair("Desc", "马勇"));
		nvps.add(new BasicNameValuePair("LocalName", null));
		nvps.add(new BasicNameValuePair("PhraseId", "0"));
		nvps.add(new BasicNameValuePair("ssid", ssid));
		nvps.add(new BasicNameValuePair("SubscribeFlag", "0"));
		nvps.add(new BasicNameValuePair("UserName", "13636532333"));

		try {
			queryPost.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		queryPost
				.addHeader(
						"Cookie",
						"IsCookiesEnable=true; webim_loginCounter=1342244257406; ccpsession="
								+ ccpsession
								+ "; webim_usersid=645048052; webim_userstatus=400; webim_login_status=0; webim_remindmsgs=645048052-39532%2521191-0-a56dcfc5f2c943adb168c91f6456fe59");
		queryPost.addHeader("Accept", "application/json, text/javascript, */*");
		queryPost.addHeader("Accept-Encoding", "gzip, deflate");
		queryPost.addHeader("Accept-Language", "zh-cn");
		queryPost.addHeader("x-requested-with", "XMLHttpRequest");
		queryPost
				.addHeader("Referer",
						"https://webim.feixin.10086.cn/content/addBuddy.htm?tabIndex=1");
		queryPost
				.addHeader(
						"User-Agent",
						"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET4.0C; .NET4.0E; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)");

		try {
			HttpResponse smResponse = getHttpclient().execute(queryPost);
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
			queryPost.abort();
		}
		return version;
	}

	private static int getContacktJsonList(String ssid,
			CookieStore cookieStroe, int version) {
		String getContactListUrl = "https://webim.feixin.10086.cn/WebIM/GetContactList.aspx?Version="
				+ version++;
		Map<String, String> postData = new HashMap<String, String>();
		postData.put("ssid", ssid);

		BasicClientCookie cookie = new BasicClientCookie("IsCookiesEnable",
				"true");
		cookie.setVersion(0);
		cookie.setDomain(".webim.feixin.10086.cn");
		cookie.setPath("/");
		cookieStroe.addCookie(cookie);

		cookie = new BasicClientCookie("webim_login_status", "0");
		cookie.setVersion(0);
		cookie.setDomain(".webim.feixin.10086.cn");
		cookie.setPath("/");
		cookieStroe.addCookie(cookie);

		cookie = new BasicClientCookie("webim_loginCounter", "1342244257406");
		cookie.setVersion(0);
		cookie.setDomain(".webim.feixin.10086.cn");
		cookie.setPath("/");
		cookieStroe.addCookie(cookie);

		cookie = new BasicClientCookie("webim_remindmsgs",
				"645048052-39532%21191-0-a56dcfc5f2c943adb168c91f6456fe59");
		cookie.setVersion(0);
		cookie.setDomain(".feixin.10086.cn");
		cookie.setPath("/");
		cookieStroe.addCookie(cookie);

		// {"rc":521,"rv":{"bl":"0","bss":1,"ln":"","rs":0,"uid":223534907,"uri":"tel:13636532333","v":"0"}}
		// JSONObject json = postTextToJson(getContactListUrl, postData);
		// String uid = null;
		// if(json.getString("rc").equals("521")){
		// uid = json.getJSONObject("rv").getString("uid");
		// log.debug("uid:" + uid);
		// }
		return version;
	}
}
