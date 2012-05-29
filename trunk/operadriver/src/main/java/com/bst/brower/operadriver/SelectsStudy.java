package com.bst.brower.operadriver;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.Select;

public class SelectsStudy {

	/**
	 * @author gongjf
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.setProperty("webdriver.firefox.bin",
				"D:\\Program Files\\Mozilla Firefox\\firefox.exe");
		WebDriver dr = new FirefoxDriver();
		dr.get("http://passport.51.com/reg2.5p");

		// 通过下拉列表中选项的索引选中第二项，即2011年
		Select selectAge = new Select(dr.findElement(By.id("User_Age")));
		selectAge.selectByIndex(2);

		// 通过下拉列表中的选项的value属性选中"上海"这一项
		Select selectShen = new Select(dr.findElement(By.id("User_Shen")));
		selectShen.selectByValue("上海");

		// 通过下拉列表中选项的可见文本选 中"浦东"这一项
		Select selectTown = new Select(dr.findElement(By.id("User_Town")));
		selectTown.selectByVisibleText("浦东");

		// 这里只是想遍历一下下拉列表所有选项，用click进行选中选项
		Select selectCity = new Select(dr.findElement(By.id("User_City")));
		for (WebElement e : selectCity.getOptions())
			e.click();
	}

}