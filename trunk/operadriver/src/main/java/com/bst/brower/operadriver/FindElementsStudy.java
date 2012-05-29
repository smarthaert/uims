package com.bst.brower.operadriver;

import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;

public class FindElementsStudy {

	/**
	 * @author gongjf
	 */
	public static void main(String[] args) {
		WebDriver driver = new FirefoxDriver();
		driver.get("http://www.51.com");

		// 定位到所有<input>标签的元素，然后输出他们的id
		List<WebElement> element = driver.findElements(By.tagName("input"));
		for (WebElement e : element) {
			System.out.println(e.getAttribute("id"));
		}

		driver.quit();
	}
}