package com.bst.brower.operadriver;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;

public class ByClassName {

	public static void main(String[] args) {
		WebDriver driver = new FirefoxDriver();
		driver.get("http://www.51.com");
		WebElement element = driver.findElement(By.className("username"));
		System.out.println(element.getTagName());

	}
}