package com.bst.brower.operadriver;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

public class CloseBrowser {
	public static void main(String[] args) {
		String url = "http://www.51.com";
		WebDriver driver = new FirefoxDriver();

		driver.get(url);

		// 用quit方法
		driver.quit();

		// 用close方法
		driver.close();
	}
}