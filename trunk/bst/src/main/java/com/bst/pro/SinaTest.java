package com.bst.pro;

import com.bst.pro.util.BasicHttpClient;

public class SinaTest extends BasicHttpClient {
	public static void main(String[] args) {
		//visit start page to get pluginUrl
		//<script type="text/javascript" src="http://js.t.sinajs.cn/t4/apps/secure/js/login/plugin.js?version=5a0ed6785bc45f79"></script>
		String startPageUrl = "http://weibo.com";
		getText(startPageUrl);
		
		//visit this page to get pinUrl
		//<img node-type="door_img" src="http://login.sina.com.cn/cgi/pin.php?r=16157100&s=0&p=fe55e24c15322ed8e655ce949078e67299d6"
		String pluginUrl = "http://js.t.sinajs.cn/t4/apps/secure/js/login/plugin.js?version=5a0ed6785bc45f79";
		getText(pluginUrl);
		
		String pinUrl = "http://login.sina.com.cn/cgi/pin.php?r=16157100&s=0&p=fe55e24c15322ed8e655ce949078e67299d6";
		getText(pinUrl);
		//Query String
		//p	fe55e24c15322ed8e655ce949078e67299d6
		//r	16157100
		//s	0
		
		String a_gifUrl = "http://beacon.sina.com.cn/a.gif?V=2&CI=sz:1400x1050|dp:16|ac:Mozilla|an:MSIE|cpu:x86|pf:Win32|jv:1.3|ct:lan|lg:zh-cn|tz:-8|fv:10|ja:1&PI=pid:0-9999-0-0-1|st:0|et:2|ref:|hp:N|PGLS:|ZT:|MT:|keys:|dom:536|ifr:0|nld:|drd:|bp:1|url:&UI=vid:879410263224.1612.1337171859734|sid:879410263224.1612.1337171859734|lv::1:1:1|un:|uo:|ae:&EX=ex1:|ex2:&gUid_1337171860078";
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
		getText(a_gifUrl);
		
		String loginUrl = "http://login.sina.com.cn/sso/login.php?client=ssologin.js(v1.3.22)";
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
	}
}
