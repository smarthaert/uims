package com.bst.brower.operadriver;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

public class OpenUrl {
	public static void main(String[] args) {
		String url = "http://www.51.com";
		WebDriver driver = new FirefoxDriver();

		// 用get方法
		driver.get(url);

		// 用navigate方法，然后再调用to方法
		driver.navigate().to(url);
	}
}