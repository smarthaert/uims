package com.bst.brower.operadriver;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.WebDriverWait;

public class WaitForSomthing {

	/**
	 * @author gongjf
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.setProperty("webdriver.firefox.bin",
				"D:\\Program Files\\Mozilla Firefox\\firefox.exe");
		WebDriver dr = new FirefoxDriver();

		// 设置10秒
		dr.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);

		String url = "file:///C:/Documents and Settings/gongjf/桌面/selenium_test/Wait.html";// "/Your/Path/to/Wait.html"
		dr.get(url);
		// 注释掉原来的
		/*
		 * WebDriverWait wait = new WebDriverWait(dr,10); wait.until(new
		 * ExpectedCondition<WebElement>(){
		 * 
		 * @Override public WebElement apply(WebDriver d) { return
		 * d.findElement(By.id("b")); }}).click();
		 */
		dr.findElement(By.id("b")).click();
		WebElement element = dr.findElement(By.cssSelector(".red_box"));
		((JavascriptExecutor) dr).executeScript(
				"arguments[0].style.border = \"5px solid yellow\"", element);

	}
}