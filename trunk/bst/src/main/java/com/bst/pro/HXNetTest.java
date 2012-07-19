package com.bst.pro;

import org.apache.log4j.Logger;

import com.bst.pro.util.BasicHttpClient;
import com.bst.pro.util.IFHQ;

public class HXNetTest extends BasicHttpClient {
	
	static Logger log = Logger.getLogger(GTradeTest.class.getName());
	
	public static void main(String[] args) {
		//use proxy 
//		setProxy("10.100.0.6", 8080, "http");
		
//		String username = "guodayaofan@163.com";
//		String password = "bgtyhnmju";
		
//		fixSelfSignedCertificate();
		setLocalCookieManger();
		
		String frmTrackUrl = "http://utrack.hexun.com/frmTrack.aspx?site=http%3A//quote.futures.hexun.com/IF1207.shtml&time=1342440043890&rsite=";		
		getText(frmTrackUrl);
		
		String userTrackUrl = "http://utrack.hexun.com/UserTrack.aspx?time=1342440043890&site=http%3a%2f%2fquote.futures.hexun.com%2fIF1207.shtml&rsite=";
//		cookie info
//		ASP.NET_SessionId	Sent	fu0urqqkceo5uh25rmu2lyjd	/	.utrack.hexun.com	(Session)	Server	Yes	No
//		HexunTrack	Received	SID=2504118437&CITY=31	/	.hexun.com	Sat, 11-Apr-2015 16:00:00 GMT	Server	No	No
		getText(userTrackUrl);
		
		
		String fRunTimeQuoteUrl = "http://quote.futures.hexun.com/2010/JsData/FRunTimeQuote.aspx?code=IF1207&market=9&&time=195130";
//		cookie info
//		ASP.NET_SessionId	Sent	txne1d453tmmrf45waov1v45	/	.quote.futures.hexun.com	(Session)		No	No
//		HexunTrack	Sent	SID=2503658023&CITY=31	/	.hexun.com	Sat, 11-Apr-2015 16:00:00 GMT	Stored	No	No
		String retStr = getTextAsString(fRunTimeQuoteUrl);
		//var dataArr=['IF1207', 'IF1207', 3, 2417, 2457, -38.8,'-1.58%', 2462, 2464.8, 2413.6, 347330, 45844,0, 0, 0, 2416.2, 2455.8,2701.38, 2210.22, 2429.802]; FRunTimeQuote.GetData(dataArr)
		String hqStr = (String) retStr.subSequence(retStr.indexOf("[") + 1, retStr.indexOf("]"));
		hqStr = hqStr.replaceAll(" ", "");
		String[] hqArr = hqStr.split(",");
		IFHQ ifhq = IFHQ.creator(hqArr[0], hqArr[1], hqArr[3], hqArr[5], hqArr[6], hqArr[7], hqArr[8], hqArr[9], hqArr[10], hqArr[11], hqArr[12], hqArr[13], hqArr[14], hqArr[15], hqArr[16], hqArr[17], hqArr[18], hqArr[19]);
		
		
		
		
		shutdown();
	}
}
