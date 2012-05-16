package com.hfutxf.war;



public class LWStart   {
	private static LittleWar client = null;
	 
	public static void main(String[] args) {
		if(client == null){
			client =  new LittleWar(args[0], args[1]);
		}
		try {
			do{ 
				LittleWar.log("开始访问游戏");
				client.start();
				LittleWar.log("结束访问游戏，等待1小时候重新开始访问");
				Thread.sleep(3600* 1000);//暂停1小时
			}while(true);
		} catch (Exception e) { 
			e.printStackTrace();
		}

	}

}
