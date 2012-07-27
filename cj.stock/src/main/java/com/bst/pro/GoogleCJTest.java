package com.bst.pro;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.bst.pro.bo.Company;
import com.bst.pro.bo.HistoricalPrices;
import com.bst.pro.bo.OptionChain;
import com.bst.pro.dao.CompanyDAO;
import com.bst.pro.dao.HistoricalPricesDAO;
import com.bst.pro.dao.OptionChainDAO;
import com.bst.pro.util.BasicHttpClient;

public class GoogleCJTest extends BasicHttpClient {

	public GoogleCJTest() {
		
	}

	static Logger log = Logger.getLogger(GoogleCJTest.class.getName());
	
	CompanyDAO companyDAO;
	HistoricalPricesDAO historicalPricesDAO;
	OptionChainDAO optionChainDAO;

	public OptionChainDAO getOptionChainDAO() {
		return optionChainDAO;
	}

	public void setOptionChainDAO(OptionChainDAO optionChainDAO) {
		this.optionChainDAO = optionChainDAO;
	}

	public HistoricalPricesDAO getHistoricalPricesDAO() {
		return historicalPricesDAO;
	}

	public void setHistoricalPricesDAO(HistoricalPricesDAO historicalPricesDAO) {
		historicalPricesDAO = historicalPricesDAO;
	}

	public CompanyDAO getCompanyDAO() {
		return companyDAO;
	}

	public void setCompanyDAO(CompanyDAO companyDAO) {
		this.companyDAO = companyDAO;
	}

	public static void main(String[] args) {
		
		// Configure Log4J
		PropertyConfigurator.configure(GoogleCJTest.class.getClassLoader().getResource(
				"log4j.properties"));


		// Start the program
		GoogleCJTest main = new GoogleCJTest();

		ApplicationContext context = 
			new ClassPathXmlApplicationContext(
					new String[] { 
								   "classpath:applicationContext-persist.xml",
								   "classpath:applicationContext-inject.xml" });
		main.companyDAO = (CompanyDAO) context.getBean("companyDAO");
		main.historicalPricesDAO = (HistoricalPricesDAO) context.getBean("historicalPricesDAO");
		main.optionChainDAO = (OptionChainDAO) context.getBean("optionChainDAO");

		main.action();
	}

	private void action() {
		init();
		
		preAction();
		
		getCompanyList();
		
//		Company com = new Company();
//		String exchange = "NYSE";
//		String ticker = "AMMM";
//		com.setExchange(exchange);
//		com.setTicker(ticker);
//		
//		getExpDateList(com);
		
		
//		http://www.google.com.hk/finance?start=20&num=20&q=%5B((exchange%20%3D%3D%20%22NYSEARCA%22)%20%7C%20(exchange%20%3D%3D%20%22NYSEAMEX%22)%20%7C%20(exchange%20%3D%3D%20%22NYSE%22)%20%7C%20(exchange%20%3D%3D%20%22NASDAQ%22))%20%26%20(market_cap%20%3E%3D%205.99)%20%26%20(market_cap%20%3C%3D%20565058000000)%20%26%20(pe_ratio%20%3E%3D%200)%20%26%20(pe_ratio%20%3C%3D%2023100)%20%26%20(change_today_percent%20%3E%3D%20-101)%20%26%20(change_today_percent%20%3C%3D%20121)%20%26%20(volume%20%3E%3D%200)%20%26%20(volume%20%3C%3D%20161000000)%20%26%20(percent_institutional_held%20%3E%3D%200)%20%26%20(percent_institutional_held%20%3C%3D%204963000000)%5D&restype=company&output=json&noIL=1&gl=cn
//		
//		PREF	Sent	ID=638c8d796be146e3:U=3beb369fdb3b1dd5:FF=2:LD=zh-CN:NW=1:TM=1342874708:LM=1342874708:S=2xmoH_UnovgcwzXp	/	.google.com.hk	Mon, 21-Jul-2014 12:45:08 GMT	Stored	No	No
//		S	Sent	quotestreamer=vQE0zDxHoQYXrc2MKzcXWg	/	.google.com.hk	(Session)	Server	Yes	No
//		SC	Sent	RV=205824:OS=:OT=:CS=V=0&CT=1:HPN=:SO=:CSO=:CUR=:PSO=:NAV=:ED=cn	/finance	.google.com.hk	Sun, 17-Jan-2038 19:14:07 GMT	Stored	No	No
//		
//		gl	cn
//		noIL	1
//		num	20
//		output	json
//		q	[((exchange == "NYSEARCA") | (exchange == "NYSEAMEX") | (exchange == "NYSE") | (exchange == "NASDAQ")) & (market_cap >= 5.99) & (market_cap <= 565058000000) & (pe_ratio >= 0) & (pe_ratio <= 23100) & (change_today_percent >= -101) & (change_today_percent <= 121) & (volume >= 0) & (volume <= 161000000)]
//		restype	company
//		start	0
		
		
	
//	getHisPriceList();
	
//	getOptList();
	
		shutdown();
	}

	private void getExpDateList(Company com) {
		String option_chainUrl = "http://www.google.com.hk/finance/option_chain?q=" +
				com.getExchange() + //"NYSE" +
				":" +
				com.getTicker() + //"AMMM" +
				"&hl=zh-CN&gl=cn";
		String html = getTextAsString(option_chainUrl);
		if(html != null){
			Pattern p = Pattern.compile("google.finance.data = ([^;]+);");
			Matcher m = p.matcher(html);
			String ocJsonStr = null;
			if (m.find()) {
				ocJsonStr = m.group(1);
				log.debug(ocJsonStr);
				if(ocJsonStr != null){//获取期权列表
					JSONObject ocJson = JSONObject.fromObject(ocJsonStr);
					String cid = ocJson.getJSONObject("option_chain").getString("underlying_id");
					//
					boolean hasOc = ocJson.getJSONObject("option_chain").has("expirations");
					if(hasOc == true){
						JSONArray expirations = ocJson.getJSONObject("option_chain").getJSONArray("expirations");
						Iterator<JSONObject> expI = expirations.iterator();
						JSONObject item = null;
						while(expI.hasNext()){
							item = expI.next();
							getOptList(cid, item.getString("d"), item.getString("m"), item.getString("y"), com);
						}
					}else{
						log.info("期权已实效：" + option_chainUrl);
					}
				}
			}else{
				log.info("获取期权列表出错：" + option_chainUrl);
			}
		}else{
			log.info("获取连接出错：" + option_chainUrl);
		}
	}

	private void getOptList(String cid, String d, String m, String y, Company com) {
		
		JSONObject retJson;
		//期权价格
		String option_chain_Url = "http://www.google.com.hk/finance/option_chain?cid=" +
				cid + //"24599" +
				"&" +
				"expd=" +
				d + //"18" +
				"&" +
				"expm=" +
				m + //"8" +
				"&" +
				"expy=" +
				y + //"2012" +
				"&" +
				"gl=cn&" +
				"output=json";
		retJson = getTextToJson(option_chain_Url);
//	http://www.google.com.hk/finance/option_chain?cid=660566&expd=18&expm=8&expy=2012&gl=cn&output=json
		//PREF	Sent	ID=638c8d796be146e3:U=3beb369fdb3b1dd5:FF=2:LD=zh-CN:NW=1:TM=1342874708:LM=1342874708:S=2xmoH_UnovgcwzXp	/	.google.com.hk	Mon, 21-Jul-2014 12:45:08 GMT	Stored	No	No
		//S	Sent	quotestreamer=x3ScXuIpQiJ9faVgiJExtQ						
		//SC	Sent	RV=660566-663427-19-205824:OS=D:OT=:CS=V=0&CT=1:HPN=:SO=:CSO=:CUR=:PSO=:NAV=:ED=cn	/finance	.google.com.hk	Sun, 17-Jan-2038 19:14:07 GMT	Stored	No	No
		//
		//gl	cn
		//hl	zh-CN
		//q	NASDAQ:EGHT
		if(retJson != null){
			List<OptionChain> optList = new ArrayList<OptionChain>();
			JSONObject exp = retJson.getJSONObject("expiry");
			String expStr = "" +
					exp.getString("y") + //"yyyy" +
					"-" +
					exp.getString("m") + //"MM" +
					"-" +
					exp.getString("d") + //"dd" +
					"";
			Iterator<JSONObject> i = null;
			JSONArray optListJson = null;
			OptionChain opt = null;
			String val = null;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			if(retJson.has("puts")){
				optListJson = retJson.getJSONArray("puts");
				i = optListJson.iterator();
				
				
				while(i.hasNext()){
					opt = new OptionChain();
					opt.setExchange(com.getExchange());
					opt.setTicker(com.getTicker());
					
					try {
						opt.setExpiration(sdf.parse(expStr));
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					opt.setOpt("puts");
					
					JSONObject item = i.next();
					opt.setStrike(Double.parseDouble(item.getString("strike").trim().replace(",", "")));
					
					val = (item.getString("p").trim().replace("-", "").length() == 0) ? "0" : item.getString("p").trim().replace("-", "");
					opt.setPrice(Double.parseDouble(val));
					
					val = (item.getString("c").trim().replace("-", "").length() == 0) ? "0" : item.getString("c").trim().replace("-", "");
					opt.setChange(Double.parseDouble(val));
					
					val = (item.getString("b").trim().replace("-", "").length() == 0) ? "0" : item.getString("b").trim().replace("-", "");
					opt.setBid(Double.parseDouble(val));
					
					val = (item.getString("a").trim().replace("-", "").length() == 0) ? "0" : item.getString("a").trim().replace("-", "");
					opt.setAsk(Double.parseDouble(val));
					
					val = (item.getString("vol").trim().replace("-", "").length() == 0) ? "0" : item.getString("vol").trim().replace("-", "");
					opt.setVolume(Long.parseLong(val));
					
					val = (item.getString("oi").trim().replace("-", "").length() == 0) ? "0" : item.getString("oi").trim().replace("-", "");
					opt.setOpenInt(Long.parseLong(val));
					
					optionChainDAO.save(opt);
					optList.add(opt);
				}
			}else{
				log.info("缺失puts。");
			}
			
			if(retJson.has("calls")){
				optListJson = retJson.getJSONArray("calls");
				i = optListJson.iterator();
				
				while(i.hasNext()){
					opt = new OptionChain();
					opt.setExchange(com.getExchange());
					opt.setTicker(com.getTicker());
					
					try {
						opt.setExpiration(sdf.parse(expStr));
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					opt.setOpt("calls");
					
					JSONObject item = i.next();
					opt.setStrike(Double.parseDouble(item.getString("strike").trim().replace(",", "")));
					
					val = (item.getString("p").trim().replace("-", "").length() == 0) ? "0" : item.getString("p").trim().replace("-", "");
					opt.setPrice(Double.parseDouble(val));
					
					val = (item.getString("c").trim().replace("-", "").length() == 0) ? "0" : item.getString("c").trim().replace("-", "");
					opt.setChange(Double.parseDouble(val));
					
					val = (item.getString("b").trim().replace("-", "").length() == 0) ? "0" : item.getString("b").trim().replace("-", "");
					opt.setBid(Double.parseDouble(val));
					
					val = (item.getString("a").trim().replace("-", "").length() == 0) ? "0" : item.getString("a").trim().replace("-", "");
					opt.setAsk(Double.parseDouble(val));
					
					val = (item.getString("vol").trim().replace("-", "").length() == 0) ? "0" : item.getString("vol").trim().replace("-", "");
					opt.setVolume(Long.parseLong(val));
					
					val = (item.getString("oi").trim().replace("-", "").length() == 0) ? "0" : item.getString("oi").trim().replace("-", "");
					opt.setOpenInt(Long.parseLong(val));
		
					optionChainDAO.save(opt);
					optList.add(opt);
				}
			}else{
				log.info("缺失calls。");
			}
		}else{
			log.info("获取期权页面失败。");
			// Todo 考虑重试。
		}
	}

	private void getHisPriceList(Company com) {
		//历史数据
		String historical_Url = "http://www.google.com.hk/finance/historical?q=" +
				com.getExchange() + //"NASDAQ" +
				"%3A" +
				com.getTicker() + //"EGHT" +
				"&hl=zh-CN&gl=cn&" +
				"start=0&" +
				"num=251&";
		Document rethtml = getText(historical_Url);
//	http://www.google.com.hk/finance/historical?q=NASDAQ%3AEGHT&hl=zh-CN&gl=cn&start=30&num=30&output=json
//	PREF	Sent	ID=638c8d796be146e3:U=3beb369fdb3b1dd5:FF=2:LD=zh-CN:NW=1:TM=1342874708:LM=1342874708:S=2xmoH_UnovgcwzXp	/	.google.com.hk	Mon, 21-Jul-2014 12:45:08 GMT	Stored	No	No
//	S	Sent	quotestreamer=x3ScXuIpQiJ9faVgiJExtQ						
//	SC	Sent	RV=660566-663427-19-205824:OS=D:OT=:CS=V=0&CT=1:HPN=:SO=:CSO=:CUR=:PSO=:NAV=:ED=cn	/finance	.google.com.hk	Sun, 17-Jan-2038 19:14:07 GMT	Stored	No	No
//
//	gl	cn
//	hl	zh-CN
//	q	NASDAQ:EGHT
		if(rethtml != null){

			List<HistoricalPrices> hisList = new ArrayList<HistoricalPrices>();
			Elements hisArr = rethtml.select("div#prices table tr:gt(0)");
			Iterator<Element> iHis = hisArr.iterator();
			HistoricalPrices his = null;
			Element item = null;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			while(iHis.hasNext()){
				his = new HistoricalPrices();
				item = iHis.next();
				try {
					his.setDate(sdf.parse(item.select("td:eq(0)").html().trim()));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				his.setOpen(Double.parseDouble(item.select("td:eq(1)").html().trim().replace(",", "")));
				his.setHigh(Double.parseDouble(item.select("td:eq(2)").html().trim().replace(",", "")));
				his.setLow(Double.parseDouble(item.select("td:eq(3)").html().trim().replace(",", "")));
				his.setClose(Double.parseDouble(item.select("td:eq(4)").html().trim().replace(",", "")));
				his.setVolume(Long.parseLong(item.select("td:eq(5)").html().trim().replace(",", "")));
				his.setExchange(com.getExchange());
				his.setTicker(com.getTicker());
				
				historicalPricesDAO.save(his);
				hisList.add(his);
			}
		}else{
			log.info("获取数据失败，URL:" + historical_Url);
		}
	}

	private void getCompanyList() {
		//股票
		String financeQuery_Url = "http://www.google.com.hk/finance?output=json&" +
				"start=0&" + //起始位置
				"num=3700&" +	//页面大小
				"noIL=1&" +	//�?
				"q=[%28%28exchange%20%3D%3D%20%22NYSEARCA%22%29%20%7C%20%28exchange%20%3D%3D%20%22NYSEAMEX%22%29%20%7C%20%28exchange%20%3D%3D%20%22NYSE%22%29%20%7C%20%28exchange%20%3D%3D%20%22NASDAQ%22%29%29%20%26%20%28market_cap%20%3E%3D%205.99%29%20%26%20%28market_cap%20%3C%3D%20565058000000%29%20%26%20%28pe_ratio%20%3E%3D%200%29%20%26%20%28pe_ratio%20%3C%3D%2023100%29%20%26%20%28change_today_percent%20%3E%3D%20-101%29%20%26%20%28change_today_percent%20%3C%3D%20121%29%20%26%20%28volume%20%3E%3D%200%29%20%26%20%28volume%20%3C%3D%20161000000%29]&" +
//				"q=[%28%28exchange%20%3D%3D%20%22NYSEARCA%22%29%20%7C%20%28exchange%20%3D%3D%20%22NYSEAMEX%22%29%20%7C%20%28exchange%20%3D%3D%20%22NYSE%22%29%20%7C%20%28exchange%20%3D%3D%20%22NASDAQ%22%29%29%20%26%20%28market_cap%20%3E%3D%205.99%29%20%26%20%28market_cap%20%3C%3D%20565058000000%29%20%26%20%28pe_ratio%20%3E%3D%200%29%20%26%20%28pe_ratio%20%3C%3D%2023100%29%20%26%20%28change_today_percent%20%3E%3D%20-101%29%20%26%20%28change_today_percent%20%3C%3D%20121%29%20%26%20%28volume%20%3E%3D%200%29%20%26%20%28volume%20%3C%3D%20161000000%29]&" +
				"restype=company&" +
				"gl=cn";
		JSONObject retJson = getTextToJson(financeQuery_Url);
		JSONArray comListJson = retJson.getJSONArray("searchresults");
		
		List<Company> comList = new ArrayList<Company>();
		Iterator<JSONObject> i = comListJson.iterator();
		Company com = null;
		while(i.hasNext()){
			com = new Company();
			JSONObject item = i.next();
			com.setTitle(item.getString("title"));
			com.setMyid(item.getString("id"));
			com.setTicker(item.getString("ticker"));
			com.setExchange(item.getString("exchange"));
			
			JSONArray colums = item.getJSONArray("columns");
			
			Iterator<JSONObject> j = colums.iterator();
			JSONObject col = null;
			String vStr = null;
			String tmp = null;
			double value = 0;
			while(j.hasNext()){
				col = j.next();
				if(col.getString("field").equals("MarketCap")){
					//处理数字单位
					 vStr = col.getString("value");
					tmp = vStr.substring(vStr.length() - 1);
					if(tmp.equals("亿")){
						value = Double.parseDouble(vStr.substring(0, vStr.length() - 1).trim()) * 100000000;
					}else if(tmp.equals("万")){
						value = Double.parseDouble(vStr.substring(0, vStr.length() - 1).trim()) * 10000;
					}else{
						
					}
					com.setMarketCap(value);
				}else if(col.getString("field").equals("PE")){
					try{
					com.setpE(Double.parseDouble(col.getString("value").trim()));
					}catch(NumberFormatException e){
						e.printStackTrace();
						vStr = col.getString("value");
						tmp = vStr.substring(vStr.length() - 1);
						if(tmp.equals("亿")){
							value = Double.parseDouble(vStr.substring(0, vStr.length() - 1).trim()) * 100000000;
						}else if(tmp.equals("万")){
							value = Double.parseDouble(vStr.substring(0, vStr.length() - 1).trim()) * 10000;
						}else{
							
						}
						com.setpE(value);
					}
				}else if(col.getString("field").equals("QuotePercChange")){
					com.setQuotePercChange(Double.parseDouble(col.getString("value").trim()));
				}else if(col.getString("field").equals("Volume")){
					//处理数字单位
					vStr = col.getString("value");
					tmp = vStr.substring(vStr.length() - 1);
					if(tmp.equals("亿")){
						value = Double.parseDouble(vStr.substring(0, vStr.length() - 1).trim()) * 100000000;
					}else if(tmp.equals("万")){
						value = Double.parseDouble(vStr.substring(0, vStr.length() - 1).trim()) * 10000;
					}else{
						
					}
					com.setVolume(value);
				}else{
					//其他的字�?
				}
			}
//			companyDAO.save(com);
//			getHisPriceList(com);
			
			getExpDateList(com);
			
			comList.add(com);
		}
	}


	private static void init() {
		setProxy("10.100.0.6", 8080, "http");
		setLocalCookieManger();
	}

	private static void preAction() {
		String chartUrl = "http://www.google.com.hk/finance/chart?cht=c&q=SHA:000001,SHE:399001&chlc=rg&tlf=24h";
		getText(chartUrl);
		
		String sc_cookie_Url = "http://www.google.com.hk/finance/stockscreener?gl=cn&hl=zh-CN&o=JSPB&_reqid=36139&rt=j";
		getText(sc_cookie_Url);
		
		String s_cookie_Url = "http://www.google.com.hk/finance/qs/test?VER=8&MODE=init&zx=kj6mfmlastmb&t=1";
		getText(s_cookie_Url);
	}
}
