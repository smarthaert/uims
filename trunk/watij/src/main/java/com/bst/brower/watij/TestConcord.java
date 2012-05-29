package com.bst.brower.watij;

import junit.framework.TestCase;
import static watij.finders.SymbolFactory.name;
import watij.runtime.ie.IE;

public class TestConcord extends TestCase {
	public void testconcordfunction() throws Exception {
		IE ie = new IE();
		// 打开 IE 浏览器
		ie.start();
		// 转到 concord77
		ie
				.goTo("http://concord77.cn.ibm.com/files/app?lang=en_US#/pinnedfiles");
		// 窗口最大化
		ie.maximize();
		// 安全认证
		ie.link(name, "overridelink").click();
		// 在输入框内输入用户名和密码
		ie.textField(name, "j_username").set("Abdul_000_006");
		ie.textField(name, "j_password").set("passw0rd");
		// 点击登陆
		ie.button("登录").click();
		// 保存结果图
		ie.screenCapture("D:\\Savelogin.png");
	}
}