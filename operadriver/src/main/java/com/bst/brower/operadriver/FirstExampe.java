package com.bst.brower.operadriver;

import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

public class FirstExampe {

	public static void main(String[] args) {
		WebDriver driver = new FirefoxDriver();
		driver.get("http://www.51.com");
		String js = "var user_input = document.getElementById(\"passport_51_user\").title;return user_input;";

		String title = (String) ((JavascriptExecutor) driver).executeScript(js);
		System.out.println(title);
	}

}