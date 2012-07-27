package com.bst.pro;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import static java.util.concurrent.TimeUnit.SECONDS;

import org.apache.http.client.CookieStore;
import org.apache.http.impl.cookie.BasicClientCookie;
import org.apache.log4j.Logger;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.bst.pro.bo.DRWT;
import com.bst.pro.bo.GTPanKou;
import com.bst.pro.bo.JHWT;
import com.bst.pro.bo.ZQZCObject;
import com.bst.pro.util.BasicHttpClient;
import com.bst.pro.util.PanKou;

public class GTradeTest extends BasicHttpClient {
	
	static Logger log = Logger.getLogger(GTradeTest.class.getName());
	static String preStartTime = "09:00:00";
	static String startTime = "09:30:00";
	String midEndTime = "11:30:00";
	String midStartTime = "13:00:00";
	static String endTime = "15:00:00";
	final static double zyp = 0.06;
	
	final static BlockingQueue queue = new LinkedBlockingQueue(100);
	static FetionTest ft = new FetionTest();
	static Map<String, String> connConf = null;
	
	
	public static void main(String[] args) {
		
		
//		batBuyStock();
		batStockWT();
		
//		caopanDemo(preStartTime, startTime, endTime);
		
		
	}

	private static void serviceInit() {
		ft.preSend();
	}

	private static void serviceDestory() {
		ft.postSend();
	}

	private static void batBuyStock() {
		initTranEnv();
		
		buyStock("7.08", "100", "d", "000753");
		buyStock("7.08", "100", "d", "000691");
		buyStock("4.30", "100", "d", "600896");
		
		logout();
		
		shutdown();
	}
	
	private static void batStockWT() {
		initTranEnv();
		
		preTran(queue);
		
		planWT(queue, zyp);
		
		logout();
		
		shutdown();
	}
	

	private static void planWT(BlockingQueue queue, double profit) {
		
		if(queue != null){
			ZQZCObject zqzc = null;
			zqzc = (ZQZCObject) queue.peek();
			if(zqzc != null){
				List<ZQZCObject.ZQZCItem> list = zqzc.getZqzcList();
				
				//保存委托
				Document doc = null;
				for(ZQZCObject.ZQZCItem item : list){
					String stockCode = item.getZqdm();
					

					String stkcode = item.getZqdm();
					double price = item.getCbj() * (1 + profit);
					DecimalFormat df = new DecimalFormat(); 
					df.setMinimumFractionDigits(2);
					df.setMaximumFractionDigits(2);
					String priceStr = df.format(price);
					
					//保存委托�?要�?�虑涨跌停价�?
					Document hqDoc = queryHq(stockCode);
					GTPanKou pk  = new GTPanKou(hqDoc, 1);

					if(price < pk.getZtj()){
					
						long qty = item.getZjsl();
						
						
						//保存计划委托�?
						String planEntrustSaveUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=planEntrustSave";
						
//							cookie info
//							BranchName	Sent	上海威海路证券营业部,上海分公司国际业务一�?	/	.trade.gtja.com	Thu, 25 Jul 2013 06:54:25 UTC	JavaScript	No	No
//							countType	Sent	Z,Z	/	.trade.gtja.com	Thu, 25 Jul 2013 06:54:25 UTC	JavaScript	No	No
//							JSESSIONID	Sent	5GG5QPXC2KhDQ2ztnTw2JdPbYwyLDq6LvD5zHDTSTbsQhX1fpZv6!-633697773!-1604152817	/	.trade.gtja.com	(Session)	Server	No	Yes
//							MyBranchCodeList	Sent	3119,3100	/	.trade.gtja.com	Thu, 25 Jul 2013 06:54:25 UTC	JavaScript	No	No
//							
//							POST data
//							optype	sale	11	
//							planTime	 	10	
//							price	7.55	10	
//							qty	1	5	
//							radiobutton	S	13	
//							redty	sale	10	
//							stkcode	000691	14	
						Map<String, String> postData = new HashMap<String, String>();
						postData.put("optype", "sale");
						postData.put("planTime", null);
						postData.put("price", priceStr);
						postData.put("qty", qty + "");
						postData.put("radiobutton", "S");
						postData.put("redty", "sale");
						postData.put("stkcode", stkcode);
						
//						doc = postTextToDoc(planEntrustSaveUrl, postData);		
					}else{
						log.info("当天不可操作证券�?" + item.getZqmc() + "|" + stockCode);
					}
				}
				
				//执行委托
				for(ZQZCObject.ZQZCItem item : list){
					//这里的doc为最后一次保存委托列表时返回的结果列�?
					Element table = doc.select("table:contains(执行结果)").get(3);
					int num = Integer.parseInt(table.select("td:containsOwn(记录个数)").html().trim().substring(5));
					Elements wtjhList = table.select("tr:gt(0)");
					Element wtjhItem = null;
					JHWT wtjh = null;
					for(int i = 0; i < num; i++){
						wtjhItem = wtjhList.get(i);
						wtjh = new JHWT(wtjhItem);
						actionPlan(wtjh.getId());
					}							
				}
			}else{
				log.info("获取证券列表出错�?");
			}
		}else{
			log.info("获取任务队列�?");
		}
		
		
//		//计划委托操作结果
//		String planEntrustListUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=planEntrustList";
//		getText(planEntrustListUrl);
//		
//		//委托单状�?
//		String searchEntrustDetailTodayUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=searchEntrustDetailToday&cancel=Y";
//		getText(searchEntrustDetailTodayUrl);
	}

	private static void actionPlan(String planEntrustExecuteId) {
//		String planEntrustExecuteId = "309994";
		//执行计划委托操作
		String planEntrustExecuteUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=planEntrustExecute&id=" +
				planEntrustExecuteId + //"309994" +
				"";
		getText(planEntrustExecuteUrl);
	}

	private static void caopanDemo(String preStartTime, String startTime,
			String endTime) {
		//定时�?
		final Timer t = new Timer();
		
		
		
		TimerTask initTranEnvTask = new TimerTask() {
			
			@Override
			public void run() {
				log.info("initTranEnvTask...");
				initTranEnv();
				preTran(queue);
					
//				serviceInit();
			}

		};
		
		TimerTask caopanActionTask = new TimerTask() {
			
			@Override
			public void run() {
				final ScheduledExecutorService scheduler = Executors
						.newScheduledThreadPool(2);
				final Runnable caopanAction = new Runnable() {

					public void run() {
//						ft.sendToSelf("天气不错，呵呵�??");
						caopanAction(zyp, ft, queue);
					}
				};
				//重复执行
				
//				09:30�?始，并每�?1分运行一�?
				final ScheduledFuture caopanActionHandler = scheduler.scheduleAtFixedRate(
						caopanAction, 1, 60, SECONDS);
				log.info("启动上午监控...");
				
//				//13:00�?始，并每�?1分运行一�?
//				final ScheduledFuture caopanActionHandler2 = scheduler.scheduleAtFixedRate(
//						caopanAction, 12600, 60, SECONDS);
////						caopanAction, 1, 60, SECONDS);
//				log.info("启动下午监控...");
				
//				 11:30结束早晨的任�?
				scheduler.schedule(new Runnable() {
					public void run() {
						caopanActionHandler.cancel(true);
						log.info("关闭上午监控...");
					}
				}, 7200, SECONDS);
				

//				// 15:00结束下午的任务，并且关闭Scheduler
//				scheduler.schedule(new Runnable() {
//					public void run() {
//						caopanActionHandler2.cancel(true);
//						log.info("关闭下午监控...");
//						scheduler.shutdown();
//						log.info("关闭监控�?...");
//					}
//				}, 19800, SECONDS);
////				}, 7200, SECONDS);
			}
		};

		TimerTask shoupanActionTask = new TimerTask() {
			
			@Override
			public void run() {		
				logout();
				
				shutdown();
//				serviceDestory();
				log.info("shoupanActionTask...");
				
				t.cancel();
			}
		};
		
		
		
		//程序实现逻辑
		//【开盘前�?
			//每天9�?00�?始初始化交易环境包括
			//登录交易用户
			
		
			//�?查当前持仓情�? 包括持仓列表
			
			//根据持仓列表【目前只考虑5条以内的持仓情况】，判断�?仓时间�?�可操作时间，开仓价格，操作价格
			//【短信�?�知用户当前的持仓列表和当天的可操作列表�?
			executeTaskAtTime(preStartTime, t, initTranEnvTask);
			
			
			
		//【开盘后�?
			//如果交易时间段且有当前可操作的持仓，循环定时扫描持仓股票行情【默认一分钟�?次�?�，根据当前行情决定如何操作
				//对于可操作股票，进行卖出操作�?
				//对于�?要平仓的股票提交平仓申请�?
				//监控平仓结果，对于成功平仓的操作，计算该股票的盈亏，短信通知用户�?
			executeTaskAtTime(startTime, t, caopanActionTask);
			//11:30休息2个小�? 13�?30�?�?
			
		
		//【收盘后】，或�?�当前无可操作的股票时，
			//计算当天累计操作盈亏和证券持仓盈亏，短信通知用户�?
			executeTaskAtTime(endTime, t, shoupanActionTask);
			
			
		
			
			
			
			
			
			
//			//对帐�?
//			String searchBillUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=searchBill";
//			getText(searchBillUrl);
//			
//			//当日委托
//			String searchEntrustDetailTodayUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=searchEntrustDetailToday";
//			getText(searchEntrustDetailTodayUrl);
//			
//			//当日成交
//			String searchDealDetailTodayUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=searchDealDetailToday";
//			getText(searchDealDetailTodayUrl);
//			
//			String getMyStockListUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=getMyStockList";
////			cookie info
////			BranchName	Sent	上海陆家嘴东路证券营业部	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
////			countType	Sent	Z	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
////			JSESSIONID	Sent	2NTJPGTGJ4bCT76hbjbtxGd9l54bFy5Mjv8K8xSSSj8NyCHvXlnK!1536183329!1528435478	/	.trade.gtja.com	(Session)		No	No
////			MyBranchCodeList	Sent	3106	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
////			
////			query string
////			method	getMyStockList
//			getText(getMyStockListUrl);
//		
		
		
		
//		String  PaperBuy = "https://trade.gtja.com/webtrade/trade/PaperBuy.jsp";
		
		
		
		
//		String b_price = "";
//		String b_qty = "";
//		String b_radiobutton = "";
//		String b_radiobutton2 = "";
//		String b_stkcode = "";
//		
//		buyStock(b_price, b_qty, b_radiobutton, b_radiobutton2, b_stkcode);
		
		
//		String webTradeAction = "https://trade.gtja.com/webtrade/trade/webTradeAction.do";
		
		//市价1
//		costprice	0	11	
//		gtja_entrust_sno	1342677629952	30	
//		price	4.71	10	
//		qty	1	5	
//		radiobutton	i	13	
//		radiobutton2	S	14	
//		saleStatus	0	12	
//		stkcode	600676	14	
		
//		costprice	0	11	
//		gtja_entrust_sno	1342677650624	30	
//		price	4.71	10	
//		qty	1	5	
//		radiobutton	r	13	
//		radiobutton2	S	14	
//		saleStatus	0	12	
//		stkcode	600676	14	
//		
//		String s_price = "";
//		String s_qty = "";
//		String s_radiobutton = "";
//		String s_radiobutton2 = "";
//		String s_stkcode = "";
//		
//		saleStock(s_price, s_qty, s_radiobutton, s_radiobutton2, s_stkcode);
		
		
//		String Papersale = "https://trade.gtja.com/webtrade/trade/Papersale.jsp";

		

	}

	private static void caopanAction(double zyp, FetionTest ft, final BlockingQueue queue) {
//		ft.sendToSelf("天气不错，呵呵�??");
		if(queue != null){
			SimpleDateFormat df =new SimpleDateFormat("hh:mm:ss"); 
			ZQZCObject zqzc = null;
			zqzc = (ZQZCObject) queue.peek();
			if(zqzc != null){
				List<ZQZCObject.ZQZCItem> list = zqzc.getZqzcList();
				
				for(ZQZCObject.ZQZCItem item : list){
					String stockCode = item.getZqdm();
					
					Document doc = queryHq(stockCode);
					PanKou pk  = new GTPanKou(doc, 1);
					log.info(stockCode + "--->>>" + df.format(new Date()) + "|" + pk.getBuyQuantity1()+ "|" + pk.getBuyPrice1() + "|" + (pk.getBuyPrice1() - (item.getCbj() * (1.0 + zyp))));
					//如果达到预期收益就进行卖出操�?
					if(pk.isSale(item.getCbj(), zyp)){
						saleStock(pk.getBuyPrice1() + "", item.getZjsl() + "", "i", stockCode);
						log.info("Sale:" + item.getZqdm() + "|" + item.getZjsl());
						zqzc.getZqzcList().remove(item);
					}
				}
			}else{
				log.info("获取证券列表出错�?");
			}
		}else{
			log.info("获取任务队列�?");
		}
	}

	private static void preTran(BlockingQueue queue) {
		//证券资产
		String searchStackDetailUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=searchStackDetail";
		//cookie info 
//			BranchName	Sent	上海威海路证券营业部	/	.trade.gtja.com	Fri, 19 Jul 2013 07:30:19 UTC	JavaScript	No	No
//			countType	Sent	Z	/	.trade.gtja.com	Fri, 19 Jul 2013 07:30:19 UTC	JavaScript	No	No
//			JSESSIONID	Sent	YyYtQH3PN22mlhtP1hhdTXnxJ8hn4X2DrvyZXB5HDzrFHdYWNMGm!1843357978!-1955906632	/	.trade.gtja.com	(Session)	Server	No	Yes
//			MyBranchCodeList	Sent	3119	/	.trade.gtja.com	Fri, 19 Jul 2013 07:30:19 UTC	JavaScript	No	No
		Document zqzcDoc = getText(searchStackDetailUrl);
		ZQZCObject zqzc = new ZQZCObject(zqzcDoc);
		//zqzc对象有证券列表和盈亏，但是没有购买时间�?�当前初始化的时候取得的列表应该都是T+1可交易的
		String smsTxt = "【开盘前】当天账户概况如下：" ;
		
		smsTxt = smsTxt + "当天证券列表如下�?";
		try {
			queue.put(zqzc);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void buy2() {
		String entrustBusinessOut2 = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=entrustBusinessOut";
//		cookie info 
//		BranchName	Sent	上海陆家嘴东路证券营业部	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		countType	Sent	Z	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		JSESSIONID	Sent	2NTJPGTGJ4bCT76hbjbtxGd9l54bFy5Mjv8K8xSSSj8NyCHvXlnK!1536183329!1528435478	/	.trade.gtja.com	(Session)		No	No
//		MyBranchCodeList	Sent	3106	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		
//		query info
//		method	entrustBusinessOut
//		
//		post data
//		costprice	4.914	15	
//		gtja_entrust_sno	1338430469300	30	
//		price	4.76	10	
//		qty	1	5	
//		radiobutton	S	13	
//		radiobutton	i	13	
//		saleStatus	0	12	
//		stkcode	600428	14	
	}

	public static void initTranEnv() {
		//初始化连接器
		init();
		
		//登录信息
		String branchCode = "3119";
		String branchName = "上海威海路证券营业部";
		String branchNameUTF8 = "%u4E0A%u6D77%u5A01%u6D77%u8DEF%u8BC1%u5238%u8425%u4E1A%u90E8";
		String inputid = "10206";
		String trdpwd = "MTk4OTIx";
		String uid = "198921";
		
		//登录用户
		login(branchCode, branchName, branchNameUTF8, inputid, trdpwd, uid);
	}

	/**
	 * 市价购买股票
	 * @param price
	 * @param qty
	 * @param radiobutton	d:五档成交剩余撤销;q:五档成交剩余转限
	 * @param stkcode
	 */
	public static void buyStock(String price, String qty, String radiobutton, String stkcode) {
//		gtja_entrust_sno	1338430423004	30	
//		price	3.02	10	
//		qty	100	7	
//		radiobutton	B	13	//radiobutton=B	正常委托 	radiobutton2=a	市价委托
//		radiobutton	d	13	//radiobutton=d	五档成交剩余撤销	radiobutton=q五档成交剩余转限
//		stkcode	601988	14	
		
		
		String entrustBusinessOut = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=entrustBusinessOut";
		
		Map<String, String> postData = new HashMap<String, String>();
		postData.put("gtja_entrust_sno", Long.toString(new Date().getTime()));
		postData.put("price", price);
		postData.put("qty", qty);
		postData.put("radiobutton2", "a");	//市价
		postData.put("radiobutton", radiobutton);
		postData.put("stkcode", stkcode);
		
		Document doc = postTextToDoc(entrustBusinessOut, postData);
		//捕捉返回状�??
		Element ret = doc.select("table:contains(委托状�??)").get(1);
		DRWT drwt = new DRWT();
		drwt.setGddm(ret.select("tr:eq(1) td:eq(1)").html().trim());
		drwt.setWtxh(ret.select("tr:eq(1) td:eq(2)").html().trim());
		drwt.setZqdm(ret.select("tr:eq(1) td:eq(3)").html().trim());
		drwt.setZqmc(ret.select("tr:eq(1) td:eq(4)").html().trim());
		drwt.setLx(ret.select("tr:eq(1) td:eq(5)").html().trim());
		drwt.setWtjg(ret.select("tr:eq(1) td:eq(6)").html().trim());
		drwt.setWtsl(ret.select("tr:eq(1) td:eq(7)").html().trim());
		drwt.setWtsj(ret.select("tr:eq(1) td:eq(8)").html().trim());
		drwt.setCjsl(ret.select("tr:eq(1) td:eq(9)").html().trim());
		drwt.setWtzt(ret.select("tr:eq(1) td:eq(10)").html().trim());
		if(stkcode.equals(drwt.getZqdm()) && price.equals(drwt.getWtjg()) && qty.equals(drwt.getWtsl())){
			log.info("委托序号�?" + drwt.getWtxh()+ "|委托价格�?" + price);
		}
		
	}

	/**
	 * 市价卖出股票
	 * @param price
	 * @param qty
	 * @param radiobutton	r:五档成交剩余转限;i:五档成交剩余撤销
	 * @param radiobutton2
	 * @param stkcode
	 */
	public static void saleStock(String price, String qty, String radiobutton, String stkcode) {
		log.info("准备售卖股票�?" + stkcode);
		String entrustBusinessOut = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=entrustBusinessOut";
		
		//市价1
//		costprice	0	11	
//		gtja_entrust_sno	1342677629952	30	
//		price	4.71	10	
//		qty	1	5	
//		radiobutton	i	13	radiobutton=S正常委托	radiobutton2=S	市价委托
//		radiobutton2	S	14	radiobutton=r五档成交剩余转限	radiobutton=i五档成交剩余撤销
//		saleStatus	0	12	
//		stkcode	600676	14	
		
//		costprice	0	11	
//		gtja_entrust_sno	1342677650624	30	
//		price	4.71	10	
//		qty	1	5	
//		radiobutton	r	13	
//		radiobutton2	S	14	
//		saleStatus	0	12	
//		stkcode	600676	14	
		Map<String, String> postData = new HashMap<String, String>();
		postData.put("costprice", "0");
		postData.put("gtja_entrust_sno", Long.toString(new Date().getTime()));
		postData.put("price", price);
		postData.put("qty", qty);
		postData.put("radiobutton", radiobutton);
		postData.put("radiobutton2", "S");	//市价
		postData.put("saleStatus", "common");
		postData.put("stkcode", stkcode);//todo java.net.SocketException: Connection reset
		
		Document doc = postTextToDoc(entrustBusinessOut, postData);
		if(doc != null){
			//捕捉返回状�??
			Element ret = doc.select("table:contains(委托状�??)").get(1);
			DRWT drwt = new DRWT();
			drwt.setGddm(ret.select("tr:eq(1) td:eq(1)").html().trim());
			drwt.setWtxh(ret.select("tr:eq(1) td:eq(2)").html().trim());
			drwt.setZqdm(ret.select("tr:eq(1) td:eq(3)").html().trim());
			drwt.setZqmc(ret.select("tr:eq(1) td:eq(4)").html().trim());
			drwt.setLx(ret.select("tr:eq(1) td:eq(5)").html().trim());
			drwt.setWtjg(ret.select("tr:eq(1) td:eq(6)").html().trim());
			drwt.setWtsl(ret.select("tr:eq(1) td:eq(7)").html().trim());
			drwt.setWtsj(ret.select("tr:eq(1) td:eq(8)").html().trim());
			drwt.setCjsl(ret.select("tr:eq(1) td:eq(9)").html().trim());
			drwt.setWtzt(ret.select("tr:eq(1) td:eq(10)").html().trim());
			if(stkcode.equals(drwt.getZqdm()) && price.equals(drwt.getWtjg()) && qty.equals(drwt.getWtsl())){
				log.info("委托序号�?" + drwt.getWtxh());
			}
		}else{
			log.info("处理售卖出错�?" + stkcode);
		}
	}

	public static void logout() {
		//0000
		String freeTokenUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=freeToken&tokenFreeInfo=ND05P030705C010204096757724304337c24bbfc973c90203cd6b2d0a6bcb7309156721274&_=";
//		String freeTokenUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=freeToken&tokenFreeInfo=ND05P010705C0103040967521607443cfebf2e49b92d1680ac111c34ae6055509767032141&_=";
//		cookie info
//		BranchName	Sent	上海陆家嘴东路证券营业部	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		countType	Sent	Z	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		JSESSIONID	Sent	2NTJPGTGJ4bCT76hbjbtxGd9l54bFy5Mjv8K8xSSSj8NyCHvXlnK!1536183329!1528435478	/	.trade.gtja.com	(Session)		No	No
//		MyBranchCodeList	Sent	3106	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		
//		query string
//		_	
//		method	freeToken
//		tokenFreeInfo	ND05P010705C0103040967521607443cfebf2e49b92d1680ac111c34ae6055509767032141
		getTextAsString(freeTokenUrl);
//		
		
		//返回登录页面
		String loginOutUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=loginOut&ssl=true";
//		cookie info
//		BranchName	Sent	上海陆家嘴东路证券营业部	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		countType	Sent	Z	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		JSESSIONID	Sent	2NTJPGTGJ4bCT76hbjbtxGd9l54bFy5Mjv8K8xSSSj8NyCHvXlnK!1536183329!1528435478	/	.trade.gtja.com	(Session)		No	No
//		MyBranchCodeList	Sent	3106	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		
//		query string
//		method	loginOut
//		ssl	true
//		
		getText(loginOutUrl);
	}

	public static void init() {
		
		//use proxy 
//		setProxy("10.100.0.6", 8080, "http");
		fixSelfSignedCertificate();
		setLocalCookieManger();
	}

	public static Document queryHq(String stockCode) {
		String getHqUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=getHq&stkcode=" +
//				"600676" +
				stockCode +
				"&bsflag=B";
//		cookie info
//		BranchName	Sent	上海陆家嘴东路证券营业部	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		countType	Sent	Z	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		JSESSIONID	Sent	2NTJPGTGJ4bCT76hbjbtxGd9l54bFy5Mjv8K8xSSSj8NyCHvXlnK!1536183329!1528435478	/	.trade.gtja.com	(Session)		No	No
//		MyBranchCodeList	Sent	3106	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		
//		query string
//		bsflag	B
//		method	getHq
//		stkcode	601988
		return getText(getHqUrl);
	}

	public static void login(String branchCode, String branchName,
			String branchNameUTF8, String inputid, String trdpwd, String uid) {
		String startPageUrl = "https://trade.gtja.com/webtrade/trade/login.jsp";
		getText(startPageUrl);
		
		String preLoginUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=preLogin";
//		BranchName	Sent	上海威海路证券营业部 	/	.trade.gtja.com	Fri, 19 Jul 2013 05:00:31 UTC	JavaScript	No	No
//		countType	Sent	Z	/	.trade.gtja.com	Fri, 19 Jul 2013 05:00:31 UTC	JavaScript	No	No
//		JSESSIONID	Sent	Fx7tQHJQs185rfbzxdtcLhydRQ5sMR694B1Jgm8pv68v5cv8SHHB!1843357978!-1955906632	/	.trade.gtja.com	(Session)	Server	No	Yes
//		MyBranchCodeList	Sent	3119	/	.trade.gtja.com	Fri, 19 Jul 2013 05:00:31 UTC	JavaScript	No	No

//		cookie info
//		BranchName	Sent	上海陆家嘴东路证券营业部	/	.trade.gtja.com	(Session)		No	No
//		countType	Sent	Z	/	.trade.gtja.com	(Session)		No	No
//		JSESSIONID	Sent	2NTJPGTGJ4bCT76hbjbtxGd9l54bFy5Mjv8K8xSSSj8NyCHvXlnK!1536183329!1528435478	/	.trade.gtja.com	(Session)		No	No
//		MyBranchCodeList	Sent	3106	/	.trade.gtja.com	(Session)		No	No
//		
//		query string
//		method	preLogin
		CookieStore cookieStroe = getCookieStroe();
//		BasicClientCookie cookie = new BasicClientCookie("BranchName", "%u4E0A%u6D77%u9646%u5BB6%u5634%u4E1C%u8DEF%u8BC1%u5238%u8425%u4E1A%u90E8=%u4E0A%u6D77%u9646%u5BB6%u5634%u4E1C%u8DEF%u8BC1%u5238%u8425%u4E1A%u90E8");
		BasicClientCookie cookie = new BasicClientCookie("BranchName", branchNameUTF8);
		cookie.setVersion(0);
		cookie.setDomain(".trade.gtja.com");
		cookie.setPath("/");
		cookieStroe.addCookie(cookie);
		
		cookie = new BasicClientCookie("countType", "Z");
		cookie.setVersion(0);
		cookie.setDomain(".trade.gtja.com");
		cookie.setPath("/");
		cookieStroe.addCookie(cookie);
		
//		cookie = new BasicClientCookie("MyBranchCodeList", "3106");
		cookie = new BasicClientCookie("MyBranchCodeList", branchCode);
		cookie.setVersion(0);
		cookie.setDomain(".trade.gtja.com");
		cookie.setPath("/");
		cookieStroe.addCookie(cookie);
		
		getText(preLoginUrl);
		
		
		
		String verifyCodeImageUrl = "https://trade.gtja.com/webtrade/commons/verifyCodeImage.jsp";
//		cookie info
//		BranchName	Sent	上海陆家嘴东路证券营业部	/	.trade.gtja.com	(Session)		No	No
//		countType	Sent	Z	/	.trade.gtja.com	(Session)		No	No
//		JSESSIONID	Sent	2NTJPGTGJ4bCT76hbjbtxGd9l54bFy5Mjv8K8xSSSj8NyCHvXlnK!1536183329!1528435478	/	.trade.gtja.com	(Session)		No	No
//		MyBranchCodeList	Sent	3106	/	.trade.gtja.com	(Session)		No	No
		String check = getChkImage(verifyCodeImageUrl);
		
		
		String getReserveMsg = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=getReserveMsg&orgid=3106&fundtype=Z&inputid=970100&ram=0.10915491733509774&_=";

		String webTradeActionUrl = "https://trade.gtja.com/webtrade/trade/webTradeAction.do";
//		cookie
//		BranchName	Sent	上海陆家嘴东路证券营业部	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		countType	Sent	Z	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		JSESSIONID	Sent	2NTJPGTGJ4bCT76hbjbtxGd9l54bFy5Mjv8K8xSSSj8NyCHvXlnK!1536183329!1528435478	/	.trade.gtja.com	(Session)		No	No
//		MyBranchCodeList	Sent	3106	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
		
//		post data
//		AppendCode	46nM	15	
//		availHeight	730	15	
//		BranchCode	3106	15	
//		BranchName	上海陆家嘴东路证券营业部	119	
//		countType	Z	11	
//		flowno		7	
//		gtja_dating_login_type	0	24	
//		hardInfo		9	
//		inputid	88000049	16	
//		logintype	common	16	
//		mac		4	
//		method	login	12	
//		Page		5	
//		pwdtype		8	
//		selectBranchCode	3100	21	
//		trdpwd	OTcwMTAw	15	
//		uid	970100	10	
//		usbkeyData		11	
//		usbkeySn		9	
//		YYBFW	10	8		
		Map<String, String> postData = new HashMap<String, String>();
		postData.put("AppendCode", check);
//		postData.put("availHeight", "730");
		postData.put("availHeight", "895");
		postData.put("BranchCode", branchCode);
		postData.put("BranchName", branchName);
		postData.put("countType", "Z");
		postData.put("flowno", null);
		postData.put("gtja_dating_login_type", "0");
		postData.put("hardInfo", null);
		postData.put("inputid", inputid);
		postData.put("logintype", "common");
		postData.put("mac", null);
		postData.put("method", "login");
		postData.put("Page", null);
		postData.put("pwdtype", null);
		postData.put("selectBranchCode", branchCode);
		postData.put("trdpwd", trdpwd);
		postData.put("uid", uid);
		postData.put("usbkeyData", null);
		postData.put("usbkeySn", null);
//		postData.put("YYBFW", "10");
		postData.put("YYBFW", "2");
		
		postText(webTradeActionUrl, postData);

		
		String topJspUrl = "https://trade.gtja.com/webtrade/trade/top.jsp";
		getText(topJspUrl);
		
//		05P030705C010203081071020609675772430001611110000000010111850022819890412824500081071020606王海�?10上海威海�?04100200004337c24bbfc973c90203cd6b2d0a6bcb73091567212741103org043119
//		05P010705C0103030735177070967521607400161111000000001011183213021985091908140007351770706周勋�?10上海陆家�?041002000043cfebf2e49b92d1680ac111c34ae60555097670321411103org043106
//		String requestToken = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=requestToken&custId=3517707&characteristic=32cfebf2e49b92d1680ac111c34ae60555&cache=0&currToken=ND000003010000&tokenRequestInfo=01010100&_=";
		String requestToken = "https://trade.gtja.com/webtrade/trade/webTradeAction.do?method=requestToken&custId=10710206&characteristic=3237c24bbfc973c90203cd6b2d0a6bcb73&cache=0&currToken=ND000003010000&tokenRequestInfo=01010100&_=";
//		cookie info
//		BranchName	Sent	上海陆家嘴东路证券营业部	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		countType	Sent	Z	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		JSESSIONID	Sent	2NTJPGTGJ4bCT76hbjbtxGd9l54bFy5Mjv8K8xSSSj8NyCHvXlnK!1536183329!1528435478	/	.trade.gtja.com	(Session)		No	No
//		MyBranchCodeList	Sent	3106	/	.trade.gtja.com	Fri, 31 May 2013 02:12:04 UTC	JavaScript	No	No
//		
//		query string
//		_	
//		cache	0
//		characteristic	32cfebf2e49b92d1680ac111c34ae60555
//		currToken	ND000003010000
//		custId	3517707
//		method	requestToken
//		tokenRequestInfo	01010100
		Document doc = getText(requestToken);
		String token = doc.select("body").html();
		if(token.length() > 0){
			log.info("成功获取令牌�?" + token);
		}else{
			log.info("获取令牌出错�?");
		}
	}
	

	/**
	 * 指定时刻执行任务
	 * @param startTimeStr
	 * @param t
	 * @param task
	 */
	private static void executeTaskAtTime(String startTimeStr, final Timer t,
			TimerTask task) {
		Date now = new Date();
		SimpleDateFormat df =new SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); 
		SimpleDateFormat dfDate=new SimpleDateFormat("yyyy-MM-dd "); 
		String dateStr = dfDate.format(now);
		
		Date d = null;
		try {
			d = df.parse(dateStr + startTimeStr);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		t.schedule(task , d);
	}
}
