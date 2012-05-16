package com.hfutxf.war;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;


public class Util {
	private static Map<String, Integer> map = new HashMap<String, Integer>();
	
	private static int getIncByName(String keyName){
		if(map.size() == 0){
			map.put("97ba558178f22af9", 1);
			map.put("8a57faa3ff0c2cd0", 2);
			map.put("b05395426617a666", 3);
			map.put("8054b38ece415448", 4);
			map.put("5a0815d2500be4c3", 5);
			map.put("cb47e040c444bb13", 6);
			map.put("4f0b466d4e838204", 7);
			map.put("9bb033dd03a03a21", 8);
			map.put("a548d6aefbeb32e0", 9);
			map.put("c156d1c03531d5f6", 10);
		}
		if(map.containsKey(keyName)){
			int v = map.get(keyName);
			return v;
		}
		throw new RuntimeException("无法找到keyName:"+keyName); 
	}
	
	/**
	 * 取到sig
	 */
	public static String getSig(String key, String keyName){
		int inc = getIncByName(keyName);
		
		String _local2  = Md5(key);
		System.out.println(_local2);
        _local2 = Md5(_local2);
        _local2 = _local2.substring(1, 7);
        _local2 = Md5(_local2);
		String p1 = _local2;
		
		
		String a = p1.substring(0, 6);
		int v = Integer.parseInt(a, 16);
		v = v + inc;
		System.out.println(v);
		a = Md5(v+"");
		return a;
	}
	
	public static  String Md5(String str){ 
	    MessageDigest messageDigest = null;  
		   
	    try {  
	        messageDigest = MessageDigest.getInstance("MD5");  
	   
	        messageDigest.reset();  
	   
	        messageDigest.update(str.getBytes("UTF-8"));  
	    } catch (NoSuchAlgorithmException e) {  
	        System.out.println("NoSuchAlgorithmException caught!");  
	        System.exit(-1);  
	    } catch (UnsupportedEncodingException e) {  
	        e.printStackTrace();  
	    }  
	    
	    byte[] byteArray = messageDigest.digest();  
	   
	    
	    StringBuffer md5StrBuff = new StringBuffer();  
	   
	    for (int i = 0; i < byteArray.length; i++) {              
	        if (Integer.toHexString(0xFF & byteArray[i]).length() == 1)  
	            md5StrBuff.append("0").append(Integer.toHexString(0xFF & byteArray[i]));  
	        else  
	            md5StrBuff.append(Integer.toHexString(0xFF & byteArray[i]));  
	    }  
	   
	    return md5StrBuff.toString();  
       
    }
}
