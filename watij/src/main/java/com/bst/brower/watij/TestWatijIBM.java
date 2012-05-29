package com.bst.brower.watij;
import static watij.finders.SymbolFactory.name;
import junit.framework.TestCase;
import watij.runtime.ie.IE;

public class TestWatijIBM extends TestCase {
	public void testgooglesearch() throws Exception {
		IE ie = new IE();
		// 打开 IE 浏览器
		ie.start();
		// 转到百度主页
		ie.goTo("www.baidu.com");
		// 在输入框内输入“IBM”
		ie.textField(name, "wd").set("IBM");
		// 点击“百度一下”进行查找
		ie.button("百度一下").click();
		// 等待 3 秒
		ie.wait(3);
	}
}