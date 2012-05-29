package com.bst.brower.operadriver;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.interactions.Actions;

public class DragAndDrop {

	/**
	 * @author gongjf
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.setProperty("webdriver.firefox.bin",
				"D:\\Program Files\\Mozilla Firefox\\firefox.exe");
		WebDriver dr = new FirefoxDriver();
		dr.get("http://koyoz.com/demo/html/drag-drop/drag-drop.html");

		// 首先new出要拖入的页面元素对象和目标对象，然后进行拖入。
		WebElement element = dr.findElement(By.id("item1"));
		WebElement target = dr.findElement(By.id("drop"));
		(new Actions(dr)).dragAndDrop(element, target).perform();

		// 利用循环把其它item也拖入
		String id = "item";
		for (int i = 2; i <= 6; i++) {
			String item = id + i;
			(new Actions(dr)).dragAndDrop(dr.findElement(By.id(item)), target)
					.perform();
		}
	}

}