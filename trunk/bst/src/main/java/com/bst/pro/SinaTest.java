package com.bst.pro;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.script.ScriptEngine;
import javax.script.ScriptException;

import org.apache.log4j.Logger;
import org.jsoup.nodes.Document;

import com.bst.pro.util.BasicHttpClient;

public class SinaTest extends BasicHttpClient {
	
	static Logger log = Logger.getLogger(SinaTest.class.getName());
	
	public static void main(String[] args) {
		//use proxy 
//		setProxy("10.100.0.6", 8080, "http");
		
		//visit start page to get pluginUrl
		//<script type="text/javascript" src="http://js.t.sinajs.cn/t4/apps/secure/js/login/plugin.js?version=5a0ed6785bc45f79"></script>
		
		//
		//wa.src = ('https:' == doc.location.protocol ? 'https://' : 'http://') + 'js.t.sinajs.cn/open/analytics/js/suda.js?version=5a0ed6785bc45f79';
		String startPageUrl = "http://weibo.com";
		Document doc = getText(startPageUrl);
		String pluginUrl = doc.select("script[src*=plugin.js]").attr("src"); 
		Pattern p = Pattern.compile("version=([^\\\"]+)");
		Matcher m = p.matcher(pluginUrl); 
		String version = null;
		if (m.find()) {
			version = m.group(1);
			log.info(version);
		}
		
		
		//sinaSSOEncoder.base64.encode(urlencode(username));
		String jsName = "javascript";
		ScriptEngine se = sem.getEngineByName(jsName);
		Object i = null;
		try {
			i = se.eval("\"\" + (new Date()).getTime();");
		} catch (ScriptException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String preloginTimeStart = i.toString();
		String preloginUrl = "http://login.sina.com.cn/sso/prelogin.php?entry=sso&callback=sinaSSOController.preloginCallBack&" +
				"su=" +
				"dW5kZWZpbmVk" +
				"&client=ssologin.js(v1.3.22)&" +
				"_=" +
				preloginTimeStart;
//				"1337171859156";
		
		//visit http://login.sina.com.cn/sso/prelogin.php?entry=sso&callback=sinaSSOController.preloginCallBack&su=dW5kZWZpbmVk&client=ssologin.js(v1.3.22)&_=1337171859156
		// to get sinaSSOController.preloginCallBack({"retcode":0,"servertime":1337171858,"pcid":"48b7b87848fc70ff5c95e1d0a243c554756c","nonce":"TASPC9"})
		//_	1337171859156
		//callback	sinaSSOController.preloginCallBack
		//client	ssologin.js(v1.3.22)
		//entry	sso
		//su	dW5kZWZpbmVk
		doc = getText(preloginUrl);
		String htmlBody = doc.select("body").html();
		p = Pattern.compile("nonce&quot;:&quot;([^\\\"]+)&quot;");
		m = p.matcher(htmlBody); 
		String nonce = null;
		if (m.find()) {
			nonce = m.group(1);
			log.info(nonce);
		}
		
		p = Pattern.compile("servertime&quot;:([0-9]+),&quot");
		m = p.matcher(htmlBody); 
		String servertime = null;
		if (m.find()) {
			servertime = m.group(1);
			log.info(servertime);
		}
		
		
		//sso.js
		String ssojs = "c:/sso.js";
		try {
			se.eval(new FileReader(new File(ssojs)));
		} catch (FileNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (ScriptException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String username = "randb001@163.com";
		String password = "zaqwsxcde";
		String sp = "";
		String su = "";
		String spFunStr = "sinaSSOEncoder.hex_sha1(\"\" + sinaSSOEncoder.hex_sha1(sinaSSOEncoder.hex_sha1('" +
				password +
//				"password" +
				"')) + '" +
				servertime +
//				"me.servertime" +
				"' + '" +
				nonce +
//				"me.nonce" +
				"')";
		Object jsRet = null;
		try {
			jsRet = se.eval(spFunStr);
		} catch (ScriptException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		sp = jsRet.toString();
		
		String suFunStr = "sinaSSOEncoder.base64.encode(encodeURIComponent('" +
				username +
//				"username" +
				"'));";
		
		jsRet = null;
		try {
			jsRet = se.eval(suFunStr);
		} catch (ScriptException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		su = jsRet.toString();
		
		
		//visit this page to get pinUrl
		//<img node-type="door_img" src="http://login.sina.com.cn/cgi/pin.php?r=16157100&s=0&p=fe55e24c15322ed8e655ce949078e67299d6"
//		String pluginUrl = "http://js.t.sinajs.cn/t4/apps/secure/js/login/plugin.js?version=5a0ed6785bc45f79";
		doc = getText(pluginUrl);
		String pinUrl = doc.select("img[node-type=door_img]").attr("src");
		
		String jsStr = doc.select("body").html();
		p = Pattern.compile("savestate:([^\\\"]+),");
		m = p.matcher(jsStr); 
		String savestate = null;
		if (m.find()) {
			savestate = m.group(1);
			log.info(savestate);
		}
		
		//visit plugin.js to get savestate
//		String pinUrl = "http://login.sina.com.cn/cgi/pin.php?r=16157100&s=0&p=fe55e24c15322ed8e655ce949078e67299d6";
		getText(pinUrl);
		
		
		//Query String
		//p	fe55e24c15322ed8e655ce949078e67299d6
		//r	16157100
		//s	0
		
		//use this js to get a_gifUrl
		String sudaJsUrl = "http://js.t.sinajs.cn/open/analytics/js/suda.js?" +
				"version=" +
				version;
//				"5a0ed6785bc45f79";
		getText(sudaJsUrl);
	
//		String jsName = "javascript";
//		ScriptEngine se = sem.getEngineByName(jsName);
//		se.eval(new FileReader(new File("1.js")));
//		Object i = null;
		try {
			i = se.eval("var D = new Date();Math.random() * 10000000000000 + \".\" + D.getTime();");
		} catch (ScriptException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String vid = i.toString();
		log.info(vid);
		String sid = vid;
		log.info(sid);
		
		String a_gifUrl = "http://beacon.sina.com.cn/a.gif?V=2" +
				"&CI=sz:1400x1050|dp:16|ac:Mozilla|an:MSIE|cpu:x86|pf:Win32|jv:1.3|ct:lan|lg:zh-cn|tz:-8|fv:10|ja:1" +
				"&PI=pid:0-9999-0-0-1|st:0|et:2|ref:|hp:N|PGLS:|ZT:|MT:|keys:|dom:536|ifr:0|nld:|drd:|bp:1|url:" +
				"&UI=vid:" +
				vid +
//				"879410263224.1612.1337171859734" +
				"|sid:" +
				sid +
//				"879410263224.1612.1337171859734" +
				"|lv::1:1:1" +
				"|un:" +
				"|uo:" +
				"|ae:" +
				"&EX=ex1:|ex2:" +
				"&gUid_1337171860078";
		URI a_gifUri = null;
		try {
			URL a_gifURL = new URL(a_gifUrl);
			a_gifUri = new URI(a_gifURL.getProtocol(), a_gifURL.getHost(), a_gifURL.getPath(), a_gifURL.getQuery(), null);
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//ULOGIN_IMG	Sent	fe55e24c15322ed8e655ce949078e67299d6	/	.sina.com.cn	(Session)			
		//SINAGLOBAL	Received	000000a9.e18d24ec.4fb39f93.96062635	/	.sina.com.cn	Sat, 14-May-22 12:37:39 GMT			
		//Apache	Received	000000a9.e12f24ec.4fb39f93.0a6dd24d	/	.sina.com.cn	(Session)			

		
		//Query String
		//CI	sz:1400x1050|dp:16|ac:Mozilla|an:MSIE|cpu:x86|pf:Win32|jv:1.3|ct:lan|lg:zh-cn|tz:-8|fv:10|ja:1
		//EX	ex1:|ex2:
		//gUid_1337171860078	
		//PI	pid:0-9999-0-0-1|st:0|et:2|ref:|hp:N|PGLS:|ZT:|MT:|keys:|dom:536|ifr:0|nld:|drd:|bp:1|url:
		//UI	vid:879410263224.1612.1337171859734|sid:879410263224.1612.1337171859734|lv::1:1:1|un:|uo:|ae:
		//V	2
		getText(a_gifUri);
		
		String loginUrl = "http://login.sina.com.cn/sso/login.php?client=ssologin.js(v1.3.22)";
		
		Map<String, String> postData = new HashMap<String, String>();
		postData.put("encoding", "UTF-8");///14	
		postData.put("entry", "weibo");///11	
		postData.put("from", "");///5	
		postData.put("gateway", "1");///9	
		postData.put("nonce", nonce);///12	
		postData.put("prelt", "203");///9	request.prelt = preloginTime;
		postData.put("pwencode", "wsse");///13	
		postData.put("returntype", "META");///15	
		postData.put("savestate", savestate);///11	o = {savestate: 7, plugin.js
		postData.put("servertime", servertime);///21	
		postData.put("service", "miniblog");///16	
		postData.put("sp", sp);///43	sinaSSOEncoder.hex_sha1("" + sinaSSOEncoder.hex_sha1(sinaSSOEncoder.hex_sha1(password)) + me.servertime + me.nonce)
		postData.put("ssosimplelogin", "1");///16	var r = {ssosimplelogin: 1};
		postData.put("su", su);///35	sinaSSOEncoder.base64.encode(urlencode(username));
		postData.put("url", "http://weibo.com/ajaxlogin.php?framelogin=1&callback=parent.sinaSSOController.feedBackUrlCallBack");///117	
		postData.put("useticket", "1");///11	
		postData.put("vsnf", "1");///6	
		
		postText(loginUrl, postData);
		
		//ULOGIN_IMG	Sent	fe55e24c15322ed8e655ce949078e67299d6	/	.sina.com.cn	(Session)			
		//tgc	Received	TGT-MjY0MTQwMTczNA==-1337171881-gz-71BFC4671CB7533EFC5EF44D6E8A5D52	/	.login.sina.com.cn	(Session)			
		//SUS	Received	SID-2641401734-1337171881-GZ-3a5uq-471549eb2871f220a296175943ce153f	/	.sina.com.cn	(Session)			
		//SUR	Received	uid=2641401734&user=a.t.jamy%40ustc.edu&nick=%E4%B9%96%E4%B9%96%E7%9A%84%E7%AC%A8%E7%AC%A8&email=&dob=&ag=4&sex=1&ssl=0	/	.sina.com.cn	Wednesday, 23-May-12 12:38:01 GMT			
		//SUP	Received	cv=1&bt=1337171881&et=1337258281&d=40c3&i=153f&us=1&vf=0&vt=0&ac=0&lt=1&uid=2641401734&user=a.t.jamy%40ustc.edu&ag=4&name=a.t.jamy%40ustc.edu&nick=%E4%B9%96%E4%B9%96%E7%9A%84%E7%AC%A8%E7%AC%A8&sex=1&ps=0&email=&dob=&ln=a.t.jamy%40ustc.edu&os=&fmp=&lcp=2012-01-16%2009%3A11%3A10	/	.sina.com.cn	(Session)			
		//SUE	Received	es=025626d3a4e18aed52e083cd2fe9dcd4&ev=v1&es2=3421e5ad0bc9b7bc114184cf066de67c&rs0=pROJfMD1I5%2Fl9SQTLUhzuzF%2FTrQ8qQN9IUycDGqGi8vFlysqRaTPz3Y8BFsjRDBRPmLlm0oiKv11kcJqYhNdywLSBqRhy0AJD4QAY5osie34L4NdWKKKt14fzsgxL7xIOM5rPscPQYtmyceF71hjtOBDAwuIs6%2FgtajUClpzybg%3D&rv=0	/	.sina.com.cn	(Session)			
		//SINAGLOBAL	Sent	000000a9.e18d24ec.4fb39f93.96062635	/	.sina.com.cn	Sat, 14-May-22 12:37:39 GMT			
		//LT	Received	1337171881	/	.login.sina.com.cn	(Session)			
		//Apache	Sent	000000a9.e12f24ec.4fb39f93.0a6dd24d	/	.sina.com.cn	(Session)			
		//ALF	Received	1337776681	/	.sina.com.cn	Wednesday, 23-May-12 12:38:01 GMT			
		//ALC	Received	ac=0&bt=1337171881&cv=3.0&et=1337776681&uid=2641401734&vf=0&vt=0&es=93620a08a004452a1b017e14bb5490b8	/	.login.sina.com.cn	Wednesday, 23-May-12 12:38:01 GMT			
		
		//POST Data
		//encoding	UTF-8	14	
		//entry	weibo	11	
		//from		5	
		//gateway	1	9	
		//nonce	TASPC9	12	
		//prelt	203	9	
		//pwencode	wsse	13	
		//returntype	META	15	
		//savestate	7	11	
		//servertime	1337171880	21	
		//service	miniblog	16	
		//sp	d93a5d867b764e63425abbc840c2f6d1d92f057c	43	
		//ssosimplelogin	1	16	
		//su	YS50LmphbXklNDB1c3RjLmVkdQ==	35	
		//url	http://weibo.com/ajaxlogin.php?framelogin=1&callback=parent.sinaSSOController.feedBackUrlCallBack	117	
		//useticket	1	11	
		//vsnf	1	6	
		
		//visit this page to get SSOLoginState
		//http://kandian.com/logon/do_crossdomain.php?action=login&savestate=1337776681&callback=sinaSSOController.doCrossDomainCallBack&scriptId=ssoscript0&client=ssologin.js(v1.3.22)&_=1337171883156
		
		
		//send mini blog
		//http://weibo.com/aj/mblog/add?__rnd=1337171949156
		//Query String
		//U_TRS1	Received	000000a9.3d015ee3.4fb39fdf.dfd00358	/	.sina.com.cn	Sat, 14-May-22 12:38:55 GMT			
		//U_TRS2	Received	000000a9.3d155ee3.4fb39fdf.4833579d	/	.sina.com.cn	(Session)			

		//_s_tentry	Sent	-	/	.weibo.com	(Session)			
		//ads_ck	Sent	1	/	.weibo.com	Thu, 17 May 2012 12:38:07 UTC			
			//ALF	Sent	1337776681	/	.weibo.com	Wed, 23-May-2012 12:38:01 GMT			
			//Apache	Sent	879410263224.1612.1337171859734	/	.weibo.com	(Session)			
			//SINAGLOBAL	Sent	879410263224.1612.1337171859734	/	.weibo.com	(Session)			
		//SinaRot/1/12442835?wvr=3.6&lf=reg	Sent	21	/	.weibo.com	Thu, 17 May 2012 12:38:06 UTC			
		//SSOLoginState	Sent	1337171870	/	.weibo.com	(Session)			
			//SUE	Sent	es=6e13315a56b2f0304a0edc20160df2cc&ev=v1&es2=9bb55245e4550483f04554583841468d&rs0=J9FJp1N6EtWBTxNph8tjCEDmqbyJ6v5U1v%2F%2Beb%2F34wNUT8MUXWOkx%2FRJq9vs4i3GaXUL4kOof8Z%2B6ces5QNw%2Fcmzrj7SLEmLD1at08N1F8DdNumF5mM4elSYXEieceVTZvqtQkKpmPE7feJ5feEVjEYTJiI%2F5ApulE1oVBBbexo%3D&rv=0	/	.weibo.com	(Session)			
			//SUP	Sent	cv=1&bt=1337171882&et=1337258282&d=c909&i=5cc4&us=1&vf=0&vt=0&ac=0&uid=2641401734&user=a.t.jamy%40ustc.edu&ag=4&name=a.t.jamy%40ustc.edu&nick=%E4%B9%96%E4%B9%96%E7%9A%84%E7%AC%A8%E7%AC%A8&fmp=&lcp=2012-01-16%2009%3A11%3A10	/	.weibo.com	(Session)			
			//SUS	Sent	SID-2641401734-1337171882-JA-ie2v4-063edd74257dab0172bd69e6ea34153f	/	.weibo.com	(Session)			
		//ULV	Sent	1337171860078:1:1:1:879410263224.1612.1337171859734:	/	.weibo.com	Sat, 11 May 2013 12:37:40 UTC			
			//un	Sent	a.t.jamy@ustc.edu	/	.weibo.com	Sat, 26 May 2012 12:38:03 UTC			
		//UOR	Sent	,weibo.com,	/	.weibo.com	Thu, 16 May 2013 12:37:39 UTC			
			//USRHAWB	Sent	usrmdins211152	/	.weibo.com	(Session)			
		//wvr	Sent	3.6	/	.weibo.com	Wed, 23 May 2012 12:37:50		
		
	}
}
