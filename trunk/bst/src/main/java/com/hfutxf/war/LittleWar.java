package com.hfutxf.war;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;

import atg.taglib.json.util.JSONArray;
import atg.taglib.json.util.JSONObject;

public class LittleWar {
	// The configuration items
	// 人人网账�?
	private String userName = "";
	// 人人网密�?
	private String password = "";

	private static String redirectURL = "http://www.renren.com/home";

	// Don't change the following URL
	private static String renRenLoginURL = "http://www.renren.com/PLogin.do";

	// The HttpClient is used in one session
	private HttpResponse response;
	private DefaultHttpClient httpclient = null;;

	public LittleWar(String userName, String password) {
		this.userName = userName;
		this.password = password;
	}

	public static void log(Object t) {
		System.out.println(new Date().toLocaleString() + t);
	}

	private boolean login() {
		if (httpclient != null) {
			log("已经登陆人人网，无需再次登陆");
			return true;
		}

		httpclient = new DefaultHttpClient();
		HttpPost httpost = new HttpPost(renRenLoginURL);
		// All the parameters post to the web site
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("origURL", redirectURL));
		nvps.add(new BasicNameValuePair("domain", "renren.com"));
		nvps.add(new BasicNameValuePair("autoLogin", "true"));
		nvps.add(new BasicNameValuePair("formName", ""));
		nvps.add(new BasicNameValuePair("method", ""));
		nvps.add(new BasicNameValuePair("submit", "登录"));
		nvps.add(new BasicNameValuePair("email", userName));
		nvps.add(new BasicNameValuePair("password", password));
		try {
			httpost.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));
			response = httpclient.execute(httpost);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			httpost.abort();
		}
		String redirectLocation = getRedirectLocation();
		if (redirectLocation != null) {
			// System.out.println(getText(redirectLocation));
			// 跳到首页，现在登录完�?
			getText(redirectLocation);
		}
		return true;
	}

	private String getRedirectLocation() {
		Header locationHeader = response.getFirstHeader("Location");
		if (locationHeader == null) {
			return null;
		}
		return locationHeader.getValue();
	}

	private String getText(String redirectLocation) {
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

	private String postText(String url, Map<String, String> values) {
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

	//
	private String inuId;
	private String sig;
	private String keyName;
	private User u = null;

	private int apiCount = 0;// 接口调用次数
	private JSONObject userRun;

	private void checkApi() {
		apiCount++;
		if (apiCount > 100) {
			// �?��重新调用userRun,重新生成sig
			log("sig过期，重新初始化");
			try {
				init();
			} catch (Exception e) {
				e.printStackTrace();
			}
			apiCount = 0;
		}

	}

	private void init() throws Exception{
    	log("�?��初始化游�?);
    	//获得后，�?��初始化小小战争页�?
		String initUrl = "http://xnapi.lw.fminutes.com/api.php?inuId="+inuId+"&method=Scene.init";
		Map<String, String> values = new HashMap<String, String>();
		values.put("data", null);
		String res1 = postText(initUrl, values);
		log("初始化完�?);
		u = new User();
		//先取得keyName
		JSONObject jsonInit = new JSONObject(res1);
		log("玩家信息�?+res1);
		//获取玩家信息
		JSONObject jsonu = jsonInit.getJSONObject("info").getJSONObject("player_info");
		u.updateNoTime(jsonu); 
		u.setSystemTime(jsonInit.getJSONObject("info").getLong("time"));
		
		//这个2个很重要，后面�?讯的基础
		keyName = jsonInit.getJSONObject("info").getJSONObject("getKey").getString("keyName");
		String key = jsonInit.getJSONObject("info").getJSONObject("getKey").getString("key");
		sig = Util.getSig(key, keyName);
		
		String runUrl = "http://xnapi.lw.fminutes.com/api.php?inuId="+inuId+"&method=Scene.run";
		values = new HashMap<String, String>();
		values.put("keyName", keyName);
		values.put("requestSig", sig);
		values.put("data","{fid:\""+u.getId()+"\"}");
		res1 = postText(runUrl, values);
		userRun = new JSONObject(res1);
    }

	/**
	 * �?��执行
	 */
	public void start() throws Exception{
        if (login()) {  
            //打开小小战争�?
            String lturl = "http://apps.renren.com/littlewar?origin=103";
            String ltPage = getText(lturl);
            Pattern p = Pattern.compile("\\\"iframe_canvas\\\"\\ssrc=\\\"([^\\\"]+)\\\"");
    		Matcher m = p.matcher(ltPage);
    		String ltifurl = "";
    		if(m.find()){
    			ltifurl = m.group(1);
    			ltifurl = ltifurl.replace("&amp;", "&");
    			log(ltifurl);
    		} 
    		String ltifpage = getText(ltifurl);
    		//获取inuId
    		p = Pattern.compile("inuId=([\\w_]+)\\&amp;");
    		m = p.matcher(ltifpage);
    		if(m.find()){
    			inuId = m.group(1);
    			log("inuId="+inuId);
    		}
    		//获得后，�?��初始化小小战争页�?
    		init();       		
    		//下面干嘛呢？查询的请求不�?��requestSig=，但是操作类的都�?��
    		//进入游戏后，先收取和生产�?
    		//先看看有没有奴隶主，有就先反抗，如果兵不够则看看自己的兵是否可以收取，如果再不够则调整奴隶兵（如果有的话）�?实在不够，则不反�?
    		
    		//功能：自动生产食物，自动生产兵，自动收取食物，兵，打怪�?反抗�?
    		//好友：挨个访问，然后偷食物�?dajie、解救（�?��攻击范围内）、打怪，（记住好友食物成熟时间，准点去�?后期功能�?
    		//定时还是周期操作，定时最好记住多久后收获、生产�?
    		
    		//1.获取建筑物列表，看看有没有要生产的食物，有则生产product.1
    		
    		//--先调整驻兵，将所有奴隶的兵调过来，那边只留下�?��兵�?
    		//--如果被占领了，并且自己的攻击力够反抗则反�?
    		
    		//生产收获食物和兵�?
    		this.gainAndProduceFood(userRun, 2);
    		this.gainAndProduceForce(userRun, 2);
    		//打�?
    		this.attackBeast(userRun, u.getId());
    		//看看有没有奴隶主，有就反抗�?这个要计算兵力，比较麻烦，先不做
    		//挨个访问好友，然后偷窃和打�?物�?攻打怪物�?��调整驻兵
    		
    		String friendUrl = "http://xnapi.lw.fminutes.com/api.php?inuId="+inuId+"&method=Friend.run";
    		Map<String, String>  values = new HashMap<String, String>();
    		values.put("keyName", keyName);
    		values.put("requestSig", "");
    		values.put("data","{friendlistVer:\""+u.getSystemTime()+"\"}"); 
    		String res1 = postText(friendUrl, values);
    		JSONObject friendsJson = new JSONObject(res1);
    		JSONObject friendsGameDataJson = friendsJson.getJSONObject("info").getJSONObject("gameData").getJSONObject("data");
    		log("好友列表�?+friendsGameDataJson);
    		List<String> friendIds = new ArrayList<String>();
    		Iterator<String> it = friendsGameDataJson.keys();
    		while(it.hasNext()){
    			friendIds.add(it.next()); 
    		}
    		//将friendIds随机排列。�?原数组id逐渐变大，会有问题的
    		Random r = new Random();
    		for(int i=0;i< friendIds.size(); i++){
    			int ri = r.nextInt(friendIds.size());
    			String t = friendIds.get(ri);    			
    			friendIds.set(ri, friendIds.get(i));
    			friendIds.set(i, t);
    		}
    		for(String fid: friendIds){
    			if(fid.equals(u.getId()))continue;
    			//暂停1�?4�?
    			Thread.sleep(1000+r.nextInt(3000));
    			try {
					this.visitFriend(fid);
				} catch (Exception e) { 
					e.printStackTrace();
					log("出错了！"+e.getMessage()); 
					init();
				}
    		}
        	 
        }
    }

	/**
	 * //访问好友 首先是偷取食物，打�?，然后是趁火打jie 如果自己兵力够则顺便救一�?
	 */
	public void visitFriend(String fId) throws Exception{
    	if("1".equals(fId)) return;
    	log("�?��访问好友�?+fId);
    	//1.获取好友信息
    	String runUrl = "http://xnapi.lw.fminutes.com/api.php?inuId="+inuId+"&method=Scene.run";
    	Map<String, String>  values = new HashMap<String, String>();
		values.put("keyName", keyName);
		values.put("requestSig", sig);
		values.put("data","{\"fid\":\""+fId+"\"}");
		String res = postText(runUrl, values);
		JSONObject jsonRun = new JSONObject(res);

		try {
			u.setLoot_times(jsonRun.getJSONObject("info").getJSONObject("enter_scene").getInt("loot_times"));
		} catch (Exception e) { 
			e.printStackTrace();
		}
    	//2.看看能不能偷
		JSONObject buildList = jsonRun.getJSONObject("info").
					getJSONObject("enter_scene").
					getJSONObject("build_info").
					getJSONObject("build_list");
		 
		Iterator<String> it = buildList.keys();
		List<JSONObject> foodBuild = new ArrayList<JSONObject>();
		while(it.hasNext()){
			JSONObject build =  buildList.getJSONObject(it.next());
			int buildId = build.getInt("build_id");
			if(buildId >= 30000 && buildId < 40000){
				foodBuild.add(build);
			}
		}
		//看看食物列表里哪个能收获�?
		JSONArray foodBuildIds = new JSONArray();//ids
		for(JSONObject build: foodBuild){
			foodBuildIds.add(build.getInt("id"));
		}
		log("好友食物工厂有："+foodBuildIds);
		//针对每个食物进行处理
		for(JSONObject build : foodBuild){   
			//看看是不是空的，可以生产，或者已经生产完成可以收�?
			long st = build.getLong("start_time");
			long et = build.getLong("end_time");
			if(st == 0){  }
			else if(et <= u.getSystemTime()){
				 //表示已经完成了，看看我自己偷过没有，没有就偷
				//先看看剩余的够不够偷�?
				int stolen = build.getInt("stolen");
				int remain = build.getInt("remain_food");
				int takeTax = build.getInt("takeTax");
				//只能�?0%
				if((stolen + takeTax)*100/(stolen + remain+takeTax) < 10){
					JSONArray stealList = build.getJSONArray("stealing_list"); 
					boolean bsteal = false;
					for(int i=0;i<stealList.size(); i++){
						String id = stealList.getString(i);
						if(id.equals(u.getId())){
							bsteal = true;
							break;
						}
					}
					if(bsteal){
						//log("已经偷过该好友食物所以不去偷取了");
						continue;//已经偷过�?					
					}
					//偷啊�?
					checkApi(); 
					String stealFoodUrl = "http://xnapi.lw.fminutes.com/api.php?inuId="+inuId+"&method=Social.stealingFood";
					values = new HashMap<String, String>();
					values.put("keyName", keyName);
					values.put("requestSig", sig);
					values.put("data","{\"desc_id\":\""+fId+"\",\"factory_id\":"+build.getInt("id")+",\"ids\":"+foodBuildIds+"}");
					res = postText(stealFoodUrl, values);
					
					JSONObject jsonR = new JSONObject(res);
					if(jsonR.getInt("result") == 0 && jsonR.get("info") != null
							&& jsonR.getJSONObject("info").get("player_info") != null){
		    			//生产成功�?
		    			log("偷取好友食物�?+values.get("data")+"成功！食�?"+jsonR.getJSONObject("info")); 
		    			JSONObject jsonu = jsonR.getJSONObject("info").getJSONObject("player_info");
		    			u.updateNoTime(jsonu);
		    		}else{
		    			log("偷取好友食物�?+values.get("data")+"失败�?);
		    		}
					Thread.sleep(500);
					
				}else{
					//log("好友食物不多，不能在偷取�?);
				}
				
			}  

		}
    	//3.看看有没有�?物打
		this.attackBeast(jsonRun, fId);
		
		//4.看看好友是不是被占领�?
		Object t = jsonRun.getJSONObject("info").getJSONObject("enter_scene").get("master_info");
		if(t instanceof JSONObject){
			JSONObject jsonMaster = (JSONObject) t;
			//看看是不是打jie过了
			Object t1 = jsonRun.getJSONObject("info").getJSONObject("enter_scene").get("loot_flag");
			if(t1 != null && -1 == Integer.valueOf(t1.toString()).intValue()){
				log("已经趁火打jie�?+values.get("data")+"过了!");
				return;
			} 
			if(u.getLoot_times() <=0 ){
				log("趁火打jie没有机会�?");
				return ;
			}
			checkApi();
			//被占领了耶�?先趁火打jie，再营救
			String dajieUrl = "http://xnapi.lw.fminutes.com/api.php?inuId="+inuId+"&method=Defence.loot";
			values = new HashMap<String, String>();
			values.put("keyName", keyName);
			values.put("requestSig", sig);
			values.put("data","{\"desc_id\":\""+fId+"\"}");
			res = postText(dajieUrl, values);
			JSONObject jsonR = new JSONObject(res);
			if(jsonR.getInt("result") == 0 && jsonR.get("info") != null
					&& jsonR.getJSONObject("info").get("player_info") != null){
    			//打jie成功�?
//				log(jsonR);
    			log("趁火打jie好友�?+values.get("data")+"成功！食�?"+jsonR.get("info")); 
    			JSONObject jsonu = jsonR.getJSONObject("info").getJSONObject("player_info");
    			u.updateNoTime(jsonu);
    		}else{
    			log("趁火打jie�?+values.get("data")+"失败�?);
    		}
			//看看自己的战斗力够不
			User master = new User();
			master.updateNoTime(jsonMaster);
			if(u.getForce() > master.getForce()){
				//TODO 营救				
			}
		}
		
    }

	/**
	 * 攻击好友或�?我自己的怪物
	 */
	public void attackBeast(JSONObject jsonRun, String toUid)throws Exception{
    	if(!(jsonRun.getJSONObject("info").getJSONObject("enter_scene").get("pve") 
    			instanceof JSONObject)){
    		//没�?物就返回
    		return ;
    	}
    	//如果攻击力不够则不攻击了
    	if(u.getForce() <= 20){
    		log("攻击力不足，无法攻击�?);
    		return ;//
    	}
    	
    	JSONObject pve = jsonRun.getJSONObject("info").getJSONObject("enter_scene").getJSONObject("pve");
		Iterator<String> pveKeys = pve.keys();
		while(pveKeys.hasNext()){
			checkApi();
	    	
			JSONObject beast = pve.getJSONObject(pveKeys.next());
			String attackBeastUrl = "http://xnapi.lw.fminutes.com/api.php?inuId="+inuId+"&method=Pve.attackBeast";
			//log(beast);
			Map<String, String> values = new HashMap<String, String>();
    		values.put("keyName", keyName);
    		values.put("requestSig", sig);
    		values.put("data","{\"pointId\":"+beast.getInt("pointId")+",\"fId\":\""+toUid+"\"}");
    		log(values.get("data"));
    		String res = postText(attackBeastUrl, values);
    		log(res);
    		JSONObject jsonR = new JSONObject(res);
    		if(jsonR.getInt("result") == 0 && jsonR.get("info") != null 
    				&& jsonR.getJSONObject("info").get("awardItemList") != null){
    			//生产成功�?
    			log("攻击怪物�?+beast+"成功！得到："+jsonR.getJSONObject("info").get("awardItemList")); 
    			JSONObject jsonu = jsonR.getJSONObject("info").getJSONObject("player_info");
    			u.updateNoTime(jsonu);
    		}else{
    			log("攻击怪物�?+beast+"失败！原因："+jsonR.get("info"));
    		}
    		Thread.sleep(500);
		}
    }

	/**
	 * 生产和收取兵�?
	 */
	public void gainAndProduceForce(JSONObject jsonRun, int forceId)
			throws Exception {
		JSONObject buildList = jsonRun.getJSONObject("info").getJSONObject(
				"enter_scene").getJSONObject("build_info").getJSONObject(
				"build_list");
		Iterator<String> it = buildList.keys();
		while (it.hasNext()) {
			JSONObject build = null;
			try {
				build = buildList.getJSONObject(it.next());
			} catch (Exception e) {
				e.printStackTrace();
				break;// 跳出循环
			}
			int buildId = build.getInt("build_id");
			if (buildId >= 30000 && buildId < 40000) {
				// 这个是食�?

			} else if (buildId >= 40000 && buildId < 50000) {
				// 兵工�?
				long st = build.getLong("start_time");
				long et = build.getLong("end_time");
				if (st == 0) {
					// 空的 。可以直接生产兵
					String data = "{\"produce_id\":" + forceId + ",\"id\":"
							+ build.getInt("id") + "}";
					this.produceForce(data);

				} else if (et <= u.getSystemTime()) {
					// 先收兵，再生产兵
					String data = "{\"id\":" + build.getInt("id") + "}";
					this.gainForce(data);
					data = "{\"produce_id\":" + forceId + ",\"id\":"
							+ build.getInt("id") + "}";
					this.produceForce(data);
				}
			}

		}
	}

	/**
	 * 生产和收获食�?
	 */
	public void gainAndProduceFood(JSONObject jsonRun, int foodId)
			throws Exception {
		JSONObject buildList = jsonRun.getJSONObject("info").getJSONObject(
				"enter_scene").getJSONObject("build_info").getJSONObject(
				"build_list");
		List<JSONObject> foodBuild = new ArrayList<JSONObject>();
		Iterator<String> it = buildList.keys();
		while (it.hasNext()) {
			JSONObject build = null;
			try {
				build = buildList.getJSONObject(it.next());
			} catch (Exception e) {
				e.printStackTrace();
				break;// 跳出循环
			}
			int buildId = build.getInt("build_id");
			if (buildId >= 30000 && buildId < 40000) {
				// 这个是食�?
				// 看看是不是空的，可以生产，或者已经生产完成可以收�?
				// 添加到列�?
				foodBuild.add(build);

				long st = build.getLong("start_time");
				long et = build.getLong("end_time");
				if (st == 0) {
					// 空的
					String data = "{\"produce_id\":" + foodId + ",\"id\":"
							+ build.getInt("id") + "}";
					this.produceFood(data);

				} else if (et <= u.getSystemTime()) {

				}

			}

		}

		// 看看食物列表里哪个能收获�?
		JSONArray foodBuildIds = new JSONArray();
		for (JSONObject build : foodBuild) {
			foodBuildIds.add(build.getInt("id"));
		}
		// 收获生产食物
		for (JSONObject build : foodBuild) {
			long st = build.getLong("start_time");
			long et = build.getLong("end_time");
			if (et != 0 && et <= u.getSystemTime()) {
				// 可以收获�?
				String data = "{\"ids\":" + foodBuildIds + ",\"id\":"
						+ build.getInt("id") + "}";
				log(data);
				this.gainFood(data);
				// 收获后再生产
				data = "{\"produce_id\":" + foodId + ",\"id\":"
						+ build.getInt("id") + "}";
				this.produceFood(data);
			}
		}
	}

	/**
	 * 收获兵力
	 */
	public String gainForce(String data) throws Exception{
    	checkApi();
    	
    	String gainFoodUrl = "http://xnapi.lw.fminutes.com/api.php?inuId="+inuId+"&method=Produce.gainRecruitment";
    	Map<String, String> values = new HashMap<String, String>();
 		values.put("keyName", keyName);
 		values.put("requestSig", sig);
 		values.put("data", data);
 		log(values.get("data"));
 		String res1 = postText(gainFoodUrl, values);
 		log(res1);
 		JSONObject jsonR = new JSONObject(res1);
		if(jsonR.getInt("result") == 0 && jsonR.get("info") != null
				&& jsonR.getJSONObject("info").get("player_info") != null){
			//生产成功�?
			log("收获兵力在build�?+data+"成功�?); 
			JSONObject jsonu = jsonR.getJSONObject("info").getJSONObject("player_info");
			u.updateNoTime(jsonu);
		}else{
			log("收获兵力在build�?+data+"失败�?);
		}
		return res1;
    }

	/**
	 * 生产兵力
	 */
	public String produceForce(String data) throws Exception{

		checkApi();
		
    	String produceFoodUrl = "http://xnapi.lw.fminutes.com/api.php?inuId="+inuId+"&method=Produce.recruiteSoldier";
    	Map<String, String>  values = new HashMap<String, String>();
		values.put("keyName", keyName);
		values.put("requestSig", sig);
		values.put("data", data);
	 
		log(values.get("data"));
		String res = postText(produceFoodUrl, values);	
		log(res);		
		JSONObject jsonR = new JSONObject(res);
		if(jsonR.getInt("result") == 0 && jsonR.get("info") != null
				&& jsonR.getJSONObject("info").get("player_info") != null){
			//生产成功�?
			log("生产兵力在build�?+data+"成功�?);
			
			JSONObject jsonu = jsonR.getJSONObject("info").getJSONObject("player_info");
			u.updateNoTime(jsonu);
		}else{
			log("生产兵力在build�?+data+"失败�?);
		}
		return res;
    }

	/**
	 * 生产食物
	 */
	public String produceFood(String data) throws Exception{
    	checkApi();
    	
    	String produceFoodUrl = "http://xnapi.lw.fminutes.com/api.php?inuId="+inuId+"&method=Produce.produceFood";
    	Map<String, String>  values = new HashMap<String, String>();
		values.put("keyName", keyName);
		values.put("requestSig", sig);
		values.put("data", data);
	 
		log(values.get("data"));
		String res = postText(produceFoodUrl, values);	
		log(res);		
		JSONObject jsonR = new JSONObject(res);
		if(jsonR.getInt("result") == 0 && jsonR.get("info") != null
				&& jsonR.getJSONObject("info").get("player_info") != null){
			//生产成功�?
			log("生产食物在build�?+data+"成功�?);
			JSONObject jsonu = jsonR.getJSONObject("info").getJSONObject("player_info");
			u.updateNoTime(jsonu);
		}else{
			log("生产食物在build�?+data+"失败�?);
		}
		return res;
    }

	/**
	 * 收获食物
	 */
	public String gainFood(String data) throws Exception{
    	checkApi();
    	
    	String gainFoodUrl = "http://xnapi.lw.fminutes.com/api.php?inuId="+inuId+"&method=Produce.gainFood";
    	Map<String, String> values = new HashMap<String, String>();
 		values.put("keyName", keyName);
 		values.put("requestSig", sig);
 		values.put("data", data);
 		log(values.get("data"));
 		String res1 = postText(gainFoodUrl, values);
 		log(res1);
 		JSONObject jsonR = new JSONObject(res1);
		if(jsonR.getInt("result") == 0 && jsonR.get("info") != null
				&& jsonR.getJSONObject("info").get("player_info") != null){
			//生产成功�?
			log("收获食物在build�?+data+"成功�?);
			JSONObject jsonu = jsonR.getJSONObject("info").getJSONObject("player_info");
			u.updateNoTime(jsonu);
			
		}else{
			log("收获食物在build�?+data+"失败�?);
		}
		return res1;
    }
}
