package com.hfutxf.facebook.api;

 
public interface IFaceBookAPIClient {

	/**
	 * 取得用户信息
	 */
	public User getUserInfo(String userId)  throws Exception;
	
	/**
	 * 取得很多用户信息
	 */
	public User[] getUserInfo(String[] userId)  throws Exception;
	
	/**
	 * 取得登陆者的用户信息
	 */
	public String getLoginUser()  throws Exception;
	
	/**
	 * 取得accessToken
	 * 返回：access_token=xxx
	 */
	public String exchangeAccessToken()  throws Exception;
	
	/**
	 * 返回已安装游戏好友的id数组
	 */
	public String[] getAppFriends()  throws Exception;
	
	/**
	 * 取得所有好友的id数组
	 */
	public String[] getAllFriends()  throws Exception;
	
	/**
	 * 是否为好友关系
	 */
	public boolean isFriend(String userId, String fId)  throws Exception;
}
