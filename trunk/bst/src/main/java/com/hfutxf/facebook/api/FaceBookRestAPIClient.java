package com.hfutxf.facebook.api;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import atg.taglib.json.util.JSONArray;
import atg.taglib.json.util.JSONObject;


public class FaceBookRestAPIClient implements IFaceBookAPIClient {

	private static String serverUrl = "https://api.facebook.com/method/";
	private static enum Method{
		USERS_GETLOGGEDINUSER("users.getLoggedInUser"),
		USERS_GETINFO("users.getInfo"),
		FRIENDS_GETAPPUSERS("friends.getAppUsers"),
		FRIENDS_GET("friends.get"),
		FRIENDS_AREFRIENDS("friends.areFriends");
		private String name;
		private Method(String name){this.name = name;}
		@Override public String toString(){return this.name+"?format=json";}		
	}
	 
	
	private String appId; 
	@SuppressWarnings("unused")
	private String apiKey;
	private String secretKey; 
	private String sessionKey;	
	private String accessToken;
	private HTTP_METHOD method = HTTP_METHOD.POST;
	private enum HTTP_METHOD{POST,GET};
	
	public void setMethod(HTTP_METHOD method) {
		this.method = method;
	}
	
	public FaceBookRestAPIClient(String appId, String apiKey, String secretKey,
			String sessionKey) throws Exception {
		super();
		this.appId = appId;
		this.apiKey = apiKey;
		this.secretKey = secretKey;
		this.sessionKey = sessionKey; 	
		
		this.exchangeAccessToken();		 
	}

	public void setSessionKey(String sessionKey) throws Exception {
		this.sessionKey = sessionKey;
		this.exchangeAccessToken();
	}
	/**
	 * 取得完整url
	 * @param method
	 * @param parameters &name=value
	 * @return
	 */
	private String getUrl(Method method, String parameters){
		return FaceBookRestAPIClient.serverUrl + method + "&"+accessToken+(parameters==null?"":parameters);
	}
	public static void main(String[] args) throws Exception{
		System.getProperties().put("proxySet", "true");  
		System.getProperties().put("proxyHost", "localhost");  
		System.getProperties().put("proxyPort", "8580");  
		
		FaceBookRestAPIClient client = new FaceBookRestAPIClient("uid", 
				"apiKey", "secretKey", 
				"sessionKey");
		client.setMethod(HTTP_METHOD.GET);
		
		String userId = client.getLoginUser();
		User u = client.getUserInfo(userId);
		System.out.println(u.getName());
		String[] ids = client.getAppFriends();
		System.out.println(ids.length);
		
		ids = client.getAllFriends();
		System.out.println(ids.length);
		
		User[] us = client.getUserInfo(ids);
		System.out.println(us.length);
		
		boolean b = client.isFriend("1000014912360", userId); 
		System.out.println(b);
	}
	@Override
	public String getLoginUser() {
		String res = this.fetchUrl(this.getUrl(Method.USERS_GETLOGGEDINUSER, null));
		if(res.startsWith("{")){
			throw new RuntimeException(""+res);
		}
		return res;
	} 
	
	@Override
	public String exchangeAccessToken() throws Exception{
		String url = "https://graph.facebook.com/oauth/exchange_sessions?"+
			"client_id="+appId + "&"+ 
			"client_secret="+secretKey + "&"+
			"sessions="+sessionKey;
		String res = fetchUrl(url); 
		JSONObject json = new JSONArray(res).getJSONObject(0); 
		System.out.println(json); 
		accessToken = "access_token="+json.getString("access_token"); 
		
		return accessToken;
	}

	@Override
	public String[] getAllFriends() throws Exception {
		String res = this.fetchUrl(this.getUrl(Method.FRIENDS_GET, null)); 		
		JSONArray ja = new JSONArray(res);
		String[] ids = new String[ja.size()];
		for(int i=0;i<ja.size();i++){
			ids[i] = ja.getString(i);
		}
		return ids;		 
	}

	@Override
	public String[] getAppFriends()  throws Exception{
		String res = this.fetchUrl(this.getUrl(Method.FRIENDS_GETAPPUSERS, null)); 
		JSONArray ja = new JSONArray(res);
		String[] ids = new String[ja.size()];
		for(int i=0;i<ja.size();i++){
			ids[i] = ja.getString(i);
		}
		return ids; 
	}
	
	@Override
	public User getUserInfo(String userId) throws Exception {
		Pair p = new Pair("uids", userId);
		Pair v = new Pair("fields", "uid,name,locale,pic_square,sex");
//		Set<UserFields> set =  
//			EnumSet.of(UserFields.UID, UserFields.NAME, UserFields.LOCALE, UserFields.PIC_SQUARE, UserFields.SEX) ;		
		//Pair v = new Pair("fields", set.toString());
		String res = this.fetchUrl(this.getUrl(Method.USERS_GETINFO, p.toString()+v));
		JSONObject json = null;
		 
		json = new JSONArray(res).getJSONObject(0);
	
		User u = new User();
		u.setImage(json.getString(UserFields.PIC_SQUARE.toString()));
		u.setLocale(json.getString(UserFields.LOCALE.toString()));
		u.setName(json.getString(UserFields.NAME.toString()));
		u.setSex(json.getString(UserFields.SEX.toString()));
		u.setUid(json.getString(UserFields.UID.toString()));
		return u;		
		 
	}
	@Override
	public boolean isFriend(String userId, String fId) throws Exception {
		Pair p1 = new Pair("uids1", userId);
		Pair p2 = new Pair("uids2", fId);
		String res = this.fetchUrl(this.getUrl(Method.FRIENDS_AREFRIENDS, p1.toString() + p2));
		JSONObject json = null; 
		json = new JSONArray(res).getJSONObject(0); 
		return json.getBoolean("are_friends"); 
	}
	@Override
	public User[] getUserInfo(String[] userId) throws Exception {
		String userIds = userId[0];
		for(int i=1;i<userId.length;i++){
			userIds += ","+userId[i];
		}
		Pair p = new Pair("uids", userIds);
		Pair v = new Pair("fields", "uid,name,locale,pic_square,sex"); 
		String res = this.fetchUrl(this.getUrl(Method.USERS_GETINFO, p.toString()+v));
		JSONArray ja = new JSONArray(res);
		User[] us = new User[ja.size()];
		for(int i=0;i<ja.size(); i++){
			JSONObject json = ja.getJSONObject(i);
			
			User u = new User();
			u.setImage(json.getString(UserFields.PIC_SQUARE.toString()));
			u.setLocale(json.getString(UserFields.LOCALE.toString()));
			u.setName(json.getString(UserFields.NAME.toString()));
			u.setSex(json.getString(UserFields.SEX.toString()));
			u.setUid(json.getString(UserFields.UID.toString()));
			us[i] = u;
		}
		
		return us;		
		 
	}
	

	private  String fetchUrl(String url){
		try{
			System.out.println("get>>>"+url);
			URL serverUrl = new URL(url);
			HttpURLConnection conn = (HttpURLConnection) serverUrl.openConnection(); 
	        conn.setRequestMethod(method.toString());//"POST" ,"GET"
	       // conn.setDoOutput(true); 
	        
	        conn.addRequestProperty("Accept-Charset", "UTF-8;");//GB2312,
	        conn.addRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.2.8) Firefox/3.6.8");
	        conn.connect();
	
	        InputStream ins =  conn.getInputStream();
	       
	        String charset = "UTF-8";
	        //check charset
//	        try{
//		        String type = conn.getHeaderField("Content-Type");  
//		        charset = type.split("charset=")[1];  
//	        }catch(Exception e){ 
//	        }finally{
//	    	    if(charset == null){
//	    		   charset = "UTF-8";
//	    	    } 
//	        }
	        InputStreamReader inr = new InputStreamReader(ins, charset);
	        BufferedReader bfr = new BufferedReader(inr);
	       
	        String line = "";
	        StringBuffer res = new StringBuffer(); 
	        do{
	    	    res.append(line);
	    	    line = bfr.readLine();
	    	   //System.out.println(line);
	        }while(line != null);
	        System.out.println(">>>==="+res);
	        return res.toString();
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}

	


	

	



}
