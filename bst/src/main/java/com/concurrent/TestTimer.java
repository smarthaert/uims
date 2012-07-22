package com.concurrent;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

public class TestTimer {
	public static void main(String[] args) {
		String startTimeStr = "19:46:00";

		final Timer t = new Timer();
		
		TimerTask task = new TimerTask() {
			
			@Override
			public void run() {
				System.out.println("start...");
				try {
					Thread.currentThread().sleep(3000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				t.cancel();
			}
		};
		
		executeTaskAtTime(startTimeStr, t, task);
		

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
