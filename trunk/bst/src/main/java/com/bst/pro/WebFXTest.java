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

//		String cookie = "webim_loginCounter=1336800284234; IsCookiesEnable=true; ";
		String cookie = "";
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
		
		
		//use this url to get uid and sip info
		//{"rc":200,"rv":{"bds":[{"bl":"2","ct":0,"is":"*","isBk":0,"ln":"","p":"identity=1;","rs":1,"uid":202101062,"uri":"sip:586995319@fetion.com.cn;p=4005"},{"bl":"2","ct":0,"is":"C,J*CAO,JIAN","isBk":0,"ln":"操健","p":"identity=1;","rs":1,"uid":222338031,"uri":"sip:723203445@fetion.com.cn;p=1760"},{"bl":"2","ct":0,"is":"Z,H,J*ZHANG,HAI,JUN","isBk":0,"ln":"张海军","p":"identity=1;","rs":0,"uid":222459841,"uri":"sip:720180373@fetion.com.cn;p=1917"},{"bl":"","ct":0,"is":"G,G*GUAI,GUAI","isBk":0,"ln":"乖乖","p":"identity=1;","rs":1,"uid":223534907,"uri":"sip:664937885@fetion.com.cn;p=2266"},{"bl":"2","ct":0,"is":"Z,H*ZHANG,HUI","isBk":0,"ln":"张慧","p":"identity=1;","rs":1,"uid":224868436,"uri":"sip:685504665@fetion.com.cn;p=20128"},{"bl":"2","ct":0,"is":"Z,H*ZUO,HUI","isBk":0,"ln":"左慧","p":"identity=1;","rs":1,"uid":226263401,"uri":"sip:882984376@fetion.com.cn;p=3513"},{"bl":"7","ct":0,"is":"H,F,X*HU,FENG,XIA","isBk":0,"ln":"胡凤霞","p":"identity=1;","rs":1,"uid":226579362,"uri":"sip:906820818@fetion.com.cn;p=20128"},{"bl":"2","ct":0,"is":"S C T,A,J*SHEN CHEN TAN,AI,JUN","isBk":0,"ln":"沈爱军","p":"identity=1;","rs":1,"uid":226656344,"uri":"sip:770629681@fetion.com.cn;p=3519"},{"bl":"2","ct":0,"is":"Z C,B*ZENG CENG,BAO","isBk":0,"ln":"曾宝","p":"identity=1;","rs":1,"uid":227024012,"uri":"sip:731779894@fetion.com.cn;p=3547"},{"bl":"2","ct":0,"is":"Z,J,J*ZHANG,JUN,JIE","isBk":0,"ln":"张军杰","p":"identity=1;","rs":1,"uid":228331985,"uri":"sip:295163834@fetion.com.cn;p=3855"},{"bl":"","ct":0,"is":"*","isBk":0,"ln":"","p":"identity=1;","rs":1,"uid":229057283,"uri":"sip:781759509@fetion.com.cn;p=4069"},{"bl":"2","ct":0,"is":"L L,Y,G*LUO LU,YONG,GUI","isBk":0,"ln":"路永桂","p":"identity=1;","rs":1,"uid":229523818,"uri":"sip:395082139@fetion.com.cn;p=4077"},{"bl":"2","ct":0,"is":"Y W,D,T Q*YU WANG,DANG,TUAN QIU","isBk":0,"ln":"王党团","p":"identity=1;","rs":1,"uid":229624881,"uri":"sip:721763833@fetion.com.cn;p=4081"},{"bl":"3","ct":0,"is":"Y,L*YANG,LING","isBk":0,"ln":"杨灵","p":"identity=1;","rs":0,"uid":229908840,"uri":"sip:681508051@fetion.com.cn;p=4087"},{"bl":"5","ct":0,"is":"M,A,L*M,A,L","isBk":0,"ln":"MaLi","p":"identity=1;","rs":1,"uid":280111483,"uri":"sip:773000701@fetion.com.cn;p=9624"},{"bl":"6","ct":0,"is":"M,F,C*MU,FANG,CHUN","isBk":0,"ln":"穆芳春","p":"","rs":1,"uid":291136652,"uri":"sip:505977673@fetion.com.cn;p=1765"},{"bl":"","ct":0,"is":"*","isBk":0,"ln":"","p":"identity=1;","rs":1,"uid":309863462,"uri":"sip:570095630@fetion.com.cn;p=4489"},{"bl":"3","ct":0,"is":"H,X,T*HU,XU,TONG","isBk":0,"ln":"胡绪同","p":"identity=1;","rs":1,"uid":366109153,"uri":"sip:624565998@fetion.com.cn;p=2456"},{"bl":"5","ct":0,"is":"M,B,A*MA,BANG,AO","isBk":0,"ln":"马帮傲","p":"identity=1;","rs":1,"uid":381460490,"uri":"sip:563957363@fetion.com.cn;p=4465"},{"bl":"2","ct":0,"is":"Y W,H,B B B*YU WANG,HONG,BI BEI BO","isBk":0,"ln":"王洪波","p":"identity=1;","rs":1,"uid":390997124,"uri":"sip:632416122@fetion.com.cn;p=6908"},{"bl":"4","ct":0,"is":"J C Q,H,B B B*JU CHOU QIU,HAI,BI BEI BO","isBk":0,"ln":"仇海波","p":"identity=1;","rs":1,"uid":391540730,"uri":"sip:648817593@fetion.com.cn;p=5461"},{"bl":"2","ct":0,"is":"Z D,Y T*ZHAO DIAO,YUE TI","isBk":0,"ln":"赵跃","p":"identity=1;","rs":0,"uid":391824947,"uri":"sip:633396498@fetion.com.cn;p=6922"},{"bl":"2","ct":0,"is":"Y W,Y W,J*YU WANG,YUN WEN,JIE","isBk":0,"ln":"王蕴杰","p":"identity=1;","rs":1,"uid":393099704,"uri":"sip:733879762@fetion.com.cn;p=7118"},{"bl":"2","ct":0,"is":"J,D*JIANG,DAN","isBk":0,"ln":"姜丹","p":"identity=1;","rs":1,"uid":402442697,"uri":"sip:174036702@fetion.com.cn;p=9114"},{"bl":"2","ct":0,"is":"L,Y*LI,YAN","isBk":0,"ln":"李燕","p":"","rs":1,"uid":402488713,"uri":"sip:778658748@fetion.com.cn;p=9113"},{"bl":"3","ct":0,"is":"Z,J*ZHANG,JING","isBk":0,"ln":"张晶","p":"identity=1;","rs":1,"uid":402872712,"uri":"sip:675519193@fetion.com.cn;p=9118"},{"bl":"4","ct":0,"is":"Z,X*ZHOU,XIA","isBk":0,"ln":"周霞","p":"identity=1;","rs":1,"uid":410745571,"uri":"sip:672657733@fetion.com.cn;p=9453"},{"bl":"3","ct":0,"is":"Z D,Y,Y*ZHAO DIAO,YU,YANG","isBk":0,"ln":"赵宇阳","p":"identity=1;","rs":1,"uid":448641173,"uri":"sip:610058784@fetion.com.cn;p=822"},{"bl":"2","ct":0,"is":"S,J,L*SONG,JIN,LING","isBk":0,"ln":"宋金玲","p":"identity=0;","rs":1,"uid":449105464,"uri":"sip:640534143@fetion.com.cn;p=919"},{"bl":"","ct":0,"is":"*","isBk":0,"ln":"","p":"identity=1;","rs":0,"uid":457404626,"uri":"sip:757497205@fetion.com.cn;p=5068"},{"bl":"3","ct":0,"is":"H,X,F*HUANG,XIAN,FENG","isBk":0,"ln":"黄先锋","p":"identity=1;","rs":1,"uid":457559236,"uri":"sip:984805945@fetion.com.cn;p=5071"},{"bl":"2","ct":0,"is":"L,G*LIN,GANG","isBk":0,"ln":"林刚","p":"identity=1;","rs":1,"uid":458139898,"uri":"sip:715576460@fetion.com.cn;p=5083"},{"bl":"2","ct":0,"is":"T,J,H*TONG,JIANG,HUA","isBk":0,"ln":"仝江华","p":"identity=1;","rs":1,"uid":458394025,"uri":"sip:442741120@fetion.com.cn;p=5090"},{"bl":"2","ct":0,"is":"L,J*LI,JUN","isBk":0,"ln":"李军","p":"identity=1;","rs":1,"uid":460487484,"uri":"sip:720182594@fetion.com.cn;p=6115"},{"bl":"3","ct":0,"is":"N,M*NIU,MING","isBk":0,"ln":"牛鸣","p":"identity=1;","rs":1,"uid":460491496,"uri":"sip:723561883@fetion.com.cn;p=6115"},{"bl":"2","ct":0,"is":"F B F,K,H*FEI BI FU,KAI,HUA","isBk":0,"ln":"费凯华","p":"identity=1;","rs":1,"uid":477945220,"uri":"sip:523470837@fetion.com.cn;p=5083"},{"bl":"2","ct":0,"is":"Z,X,J*ZHOU,XUN,JIAN","isBk":0,"ln":"周勋建","p":"identity=1;","rs":1,"uid":483639675,"uri":"sip:965977271@fetion.com.cn;p=3513"},{"bl":"3","ct":0,"is":"Z,Y*ZHANG,YU","isBk":0,"ln":"张煜","p":"identity=1;","rs":1,"uid":499011451,"uri":"sip:523581341@fetion.com.cn;p=6011"},{"bl":"2","ct":0,"is":"*","isBk":0,"ln":"","p":"identity=1;","rs":1,"uid":529318669,"uri":"sip:904892824@fetion.com.cn;p=2018"},{"bl":"4","ct":0,"is":"X J Y,Q Q*XIA JIA YAN,QIN QI","isBk":0,"ln":"夏勤","p":"identity=1;","rs":1,"uid":565182066,"uri":"sip:171476919@fetion.com.cn;p=5522"},{"bl":"5","ct":0,"is":"D,O,N*D,O,N","isBk":0,"ln":"DONGRUI","p":"identity=1;","rs":0,"uid":599226727,"uri":"tel:13485644999"},{"bl":"3","ct":0,"is":"H,D*HAN,DONG","isBk":0,"ln":"韩冬","p":"identity=1;","rs":1,"uid":629090774,"uri":"sip:871311686@fetion.com.cn;p=12120"},{"bl":"2","ct":0,"is":"S,W*SONG,WEI","isBk":0,"ln":"宋伟","p":"identity=1;","rs":1,"uid":629114927,"uri":"sip:920586674@fetion.com.cn;p=12244"},{"bl":"2","ct":0,"is":"T T Y,L*TIAO TAO YAO,LEI","isBk":0,"ln":"姚磊","p":"identity=1;","rs":1,"uid":630715897,"uri":"sip:523495429@fetion.com.cn;p=5064"},{"bl":"2","ct":0,"is":"T D,Y,B B P P*TU DU,YI,BING BENG PIAN PING","isBk":0,"ln":"杜一平","p":"identity=1;","rs":1,"uid":630754274,"uri":"sip:889384508@fetion.com.cn;p=12244"},{"bl":"3","ct":0,"is":"Z,X,H*ZHANG,XIAO,HUA","isBk":0,"ln":"张小花","p":"identity=1;","rs":1,"uid":659612405,"uri":"sip:918108161@fetion.com.cn;p=862"},{"bl":"3","ct":0,"is":"*","isBk":0,"ln":"","p":"identity=1;","rs":1,"uid":668207347,"uri":"sip:929622372@fetion.com.cn;p=4013"},{"bl":"5","ct":0,"is":"M,A,Y*M,A,Y","isBk":0,"ln":"MAYING","p":"identity=1;","rs":0,"uid":707514097,"uri":"tel:15855589810"},{"bl":"","ct":0,"is":"*","isBk":0,"ln":"","p":"identity=1;","rs":1,"uid":721976350,"uri":"sip:984790161@fetion.com.cn;p=10461"},{"bl":"3","ct":0,"is":"H,W,D*HE,WEI,DONG","isBk":0,"ln":"何卫东","p":"identity=1;","rs":1,"uid":750860089,"uri":"sip:509626314@fetion.com.cn;p=7515"},{"bl":"","ct":0,"is":"*","isBk":0,"ln":"","p":"identity=1;","rs":1,"uid":888983017,"uri":"sip:361855821@fetion.com.cn;p=4080"},{"bl":"0","ct":0,"is":"Y S,F*YE SHU,FENG","isBk":0,"ln":"野枫","p":"identity=1;","rs":1,"uid":991586740,"uri":"sip:146600730@fetion.com.cn;p=16101"},{"bl":"5","ct":0,"is":"M,B,N*M,B,N","isBk":0,"ln":"MBN","p":"identity=1;","rs":1,"uid":995520147,"uri":"sip:150126843@fetion.com.cn;p=5462"},{"bl":"1","ct":0,"is":"*","isBk":0,"ln":"","p":"identity=1;","rs":1,"uid":996886633,"uri":"sip:165199662@fetion.com.cn;p=7116"}],"bl":[{"id":1,"n":"我的好友"},{"id":2,"n":"BOC"},{"id":3,"n":"USTC"},{"id":4,"n":"SC"},{"id":5,"n":"kazaoku"},{"id":6,"n":"XINYOU"},{"id":7,"n":"DAIGAKU"}],"v":"390245988"}}
		//https://webim.feixin.10086.cn/WebIM/GetContactList.aspx?Version=3
		//https://webim.feixin.10086.cn/WebIM/GetConnect.aspx?Version=4
		//Cookie Info
			//ccpsession	Sent	91401c44-a62d-4169-ad30-18f24b772494	/	webim.feixin.10086.cn	(Session)	Server	No	No
			//IsCookiesEnable	Sent	true	/	webim.feixin.10086.cn	(Session)	Server	No	No
			//webim_login_status	Sent	0	/	webim.feixin.10086.cn	Mon, 31 Jan 2033 16:00:00 GMT	JavaScript	No	No
			//webim_loginCounter	Sent	1337956822899	/	webim.feixin.10086.cn	Fri, 25 May 2012 14:40:22 GMT	JavaScript	No	No
			//webim_remindmsgs	Sent	645048052-39532%21191-0-fe65029b067d4fde97ad85d8eb7f072b	/	.feixin.10086.cn	Fri, 25 May 2012 13:42:47 GMT	JavaScript	No	No
			//webim_usersid	Sent	645048052	/	webim.feixin.10086.cn	(Session)	Server	No	No
			//webim_userstatus	Sent	400	/	webim.feixin.10086.cn	(Session)	Server	No	No
		//Query String
			//Version	3
		//Post Data
			//222857364p20172-fe65029b-067d-4fde-97ad-85d8eb7f072b
		
		
		//use this url to query uid by phone number
		//{"rc":521,"rv":{"bl":"0","bss":1,"ln":"","rs":0,"uid":223534907,"uri":"tel:13636532333","v":"0"}}
		//https://webim.feixin.10086.cn/content/WebIM/AddBuddy.aspx?Version=13
		//Cookie Info
			//_PHPAUTH	Sent	xAY+w2bNZ9481YKO36uu9nR1LA+RzH/PhQBGHvIVk5/3RGKnADkQlWZJj8/hAM1oP2OmzkJJ3b6IF1cc8O/Rj60tJ9eN72sE3EXNMu/YUJaUpvPupdbj75O2vEpev3up	/	.feixin.10086.cn	(Session)	Server	No	No
			//ccpsession	Sent	91401c44-a62d-4169-ad30-18f24b772494	/	webim.feixin.10086.cn	(Session)	Server	No	No
			//IsCookiesEnable	Sent	true	/	webim.feixin.10086.cn	(Session)	Server	No	No
			//l7sessV1	Sent	i2.feixin.10086.cn	/	.feixin.10086.cn	(Session)	Server	No	No
			//webim_login_status	Sent	0	/	webim.feixin.10086.cn	Mon, 31 Jan 2033 16:00:00 GMT	JavaScript	No	No
			//webim_loginCounter	Sent	1337956822899	/	webim.feixin.10086.cn	Fri, 25 May 2012 14:40:22 GMT	JavaScript	No	No
			//webim_remindmsgs	Sent	645048052-39532%21191-0-fe65029b067d4fde97ad85d8eb7f072b	/	.feixin.10086.cn	Fri, 25 May 2012 13:45:37 GMT	JavaScript	No	No
			//webim_usersid	Sent	645048052	/	webim.feixin.10086.cn	(Session)	Server	No	No
			//webim_userstatus	Sent	400	/	webim.feixin.10086.cn	(Session)	Server	No	No
		//Query info
			//Version	13
		//Post Data
			//AddType	1	9	
			//BuddyLists	0	12	
			//Ccp	mfx2	8	
			//CcpId	21a42545-c3ff-4881-9f54-2fea729ec4a4	42	
			//Desc	马勇	23	
			//LocalName		10	
			//PhraseId	0	10	
			//ssid	222857364p20172-fe65029b-067d-4fde-97ad-85d8eb7f072b	57	
			//SubscribeFlag	0	15	
			//UserName	13636532333	20	
//		HttpPost queryUid = new HttpPost("https://webim.feixin.10086.cn/content/WebIM/AddBuddy.aspx?Version=1");
//		
//		nvps = new ArrayList<NameValuePair>();
//		nvps.add(new BasicNameValuePair("AddType", "1"));
//		nvps.add(new BasicNameValuePair("BuddyLists", "0"));
//		nvps.add(new BasicNameValuePair("Ccp", ccp));
//		nvps.add(new BasicNameValuePair("CcpId", ccpId));
//		nvps.add(new BasicNameValuePair("Desc", "马勇"));
//		nvps.add(new BasicNameValuePair("LocalName", ""));
//		nvps.add(new BasicNameValuePair("PhraseId", "0"));
//		nvps.add(new BasicNameValuePair("ssid", ssid));
//		nvps.add(new BasicNameValuePair("SubscribeFlag", "0"));
//		nvps.add(new BasicNameValuePair("UserName", "13636532333"));
//		
		

		
		
		HttpPost smPost = new HttpPost(
				"https://webim.feixin.10086.cn/WebIM/SendMsg.aspx?Version=2");

		nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("IsSendSms", "0"));
		nvps.add(new BasicNameValuePair("msg", "今天外面不下雨哦。"));
		nvps.add(new BasicNameValuePair("ssid", ssid));
		nvps.add(new BasicNameValuePair("To", "223534907"));
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
				"https://webim.feixin.10086.cn/WebIM/SendMsg.aspx?Version=3");

		nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("IsSendSms", "0"));
		nvps.add(new BasicNameValuePair("msg", "加油～加油～！。"));
		nvps.add(new BasicNameValuePair("ssid", ssid));
		nvps.add(new BasicNameValuePair("To", "223534907"));//    * 664937885//13636532333
//		nvps.add(new BasicNameValuePair("To", "888983017"));
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
	
		//logout system
		//https://webim.feixin.10086.cn/WebIM/Logout.aspx?Version=13

		httpclient.getConnectionManager().shutdown();
	}
}
