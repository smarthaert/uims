package com.bst.brower.operadriver;

import java.util.Iterator;
import java.util.Set;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

public class PopupWindowTest {

	/**
	 * @author gongjf
	 */
	public static void main(String[] args) {
		System.setProperty("webdriver.firefox.bin",
				"D:\\Program Files\\Mozilla Firefox\\firefox.exe");
		WebDriver dr = new FirefoxDriver();
		String url = "\\Your\\Path\\to\\main.html";
		dr.get(url);
		dr.findElement(By.id("51")).click();
		// 得到当前窗口的句柄
		String currentWindow = dr.getWindowHandle();
		// 得到所有窗口的句柄
		Set<String> handles = dr.getWindowHandles();
		Iterator<String> it = handles.iterator();
		while (it.hasNext()) {
			if (currentWindow == it.next())
				continue;
			WebDriver window = dr.switchTo().window(it.next());
			System.out.println("title,url = " + window.getTitle() + ","
					+ window.getCurrentUrl());
		}
	}

}