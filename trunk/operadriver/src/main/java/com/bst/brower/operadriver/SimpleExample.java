package com.bst.brower.operadriver;

import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

public class SimpleExample {

	public static void main(String[] args) {
		WebDriver driver = new FirefoxDriver();

		((JavascriptExecutor) driver)
				.executeScript("alert(\"hello,this is a alert!\")");
	}

}