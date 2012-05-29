package com.bst.brower.operadriver;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.thoughtworks.selenium.DefaultSelenium;
import com.thoughtworks.selenium.SeleneseTestCase;

/**
 * 需要单独启动Selenium服务器
 * @author Administrator
 *
 */
public class SeleniumTest extends SeleneseTestCase {
    @Before
    public void setUp() throws Exception {
        selenium = new DefaultSelenium("localhost", 4444, "*iexplore",
                "http://www.baidu.com/");
                selenium.start();
    }

    @Test
    public void testTest() throws Exception {
        selenium.open("/");
        selenium.type("id=kw", "aaaa");
        selenium.click("id=su"); 
            }

    @After
    public void tearDown() throws Exception {
        selenium.stop();
    }
 }
