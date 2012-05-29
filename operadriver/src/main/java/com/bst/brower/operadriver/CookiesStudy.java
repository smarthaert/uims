package com.bst.brower.operadriver;

import java.util.Set;

import org.openqa.selenium.Cookie;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

public class CookiesStudy {

	/**
	 * @author gongjf
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.setProperty("webdriver.firefox.bin",
				"D:\\Program Files\\Mozilla Firefox\\firefox.exe");
		WebDriver dr = new FirefoxDriver();
		dr.get("http://www.51.com");

		// 增加一个name = "name",value="value"的cookie
		Cookie cookie = new Cookie("name", "value");
		dr.manage().addCookie(cookie);

		// 得到当前页面下所有的cookies，并且输出它们的所在域、name、value、有效日期和路径
		Set<Cookie> cookies = dr.manage().getCookies();
		System.out.println(String
				.format("Domain -> name -> value -> expiry -> path"));
		for (Cookie c : cookies)
			System.out.println(String.format("%s -> %s -> %s -> %s -> %s", c
					.getDomain(), c.getName(), c.getValue(), c.getExpiry(), c
					.getPath()));

		// 删除cookie有三种方法

		// 第一种通过cookie的name
		dr.manage().deleteCookieNamed("CookieName");
		// 第二种通过Cookie对象
		dr.manage().deleteCookie(cookie);
		// 第三种全部删除
		dr.manage().deleteAllCookies();
	}
}