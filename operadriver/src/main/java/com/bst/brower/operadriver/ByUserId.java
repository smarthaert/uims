package com.bst.brower.operadriver;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;

public class ByUserId {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		WebDriver dr = new FirefoxDriver();
		dr.get("http://www.51.com");

		WebElement element = dr.findElement(By.id("passport_51_user"));
		System.out.println(element.getAttribute("title"));
	}

}