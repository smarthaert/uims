package com.bst.brower.operadriver;

import java.io.File;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import org.apache.commons.io.FileUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.Cookie;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.Point;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.WebDriver.Timeouts;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.Select;

public class ActionDriverHelper {
	protected WebDriver driver;

	public ActionDriverHelper(WebDriver driver) {
		this.driver = driver;
	}

	public void click(By by) {
		driver.findElement(by).click();
	}

	public void doubleClick(By by) {
		new Actions(driver).doubleClick(driver.findElement(by)).perform();
	}

	public void contextMenu(By by) {
		new Actions(driver).contextClick(driver.findElement(by)).perform();
	}

	public void clickAt(By by, String coordString) {
		int index = coordString.trim().indexOf(',');
		int xOffset = Integer.parseInt(coordString.trim().substring(0, index));
		int yOffset = Integer.parseInt(coordString.trim().substring(index + 1));
		new Actions(driver).moveToElement(driver.findElement(by), xOffset,
				yOffset).click().perform();
	}

	public void doubleClickAt(By by, String coordString) {
		int index = coordString.trim().indexOf(',');
		int xOffset = Integer.parseInt(coordString.trim().substring(0, index));
		int yOffset = Integer.parseInt(coordString.trim().substring(index + 1));
		new Actions(driver).moveToElement(driver.findElement(by), xOffset,
				yOffset).doubleClick(driver.findElement(by)).perform();
	}

	public void contextMenuAt(By by, String coordString) {
		int index = coordString.trim().indexOf(',');
		int xOffset = Integer.parseInt(coordString.trim().substring(0, index));
		int yOffset = Integer.parseInt(coordString.trim().substring(index + 1));
		new Actions(driver).moveToElement(driver.findElement(by), xOffset,
				yOffset).contextClick(driver.findElement(by)).perform();
	}

	public void fireEvent(By by, String eventName) {
		System.out.println("webdriver 不建议使用这样的方法，所以没有实现。");
	}

	public void focus(By by) {
		System.out.println("webdriver 不建议使用这样的方法，所以没有实现。");
	}

	public void keyPress(By by, Keys theKey) {
		new Actions(driver).keyDown(driver.findElement(by), theKey).release()
				.perform();
	}

	public void shiftKeyDown() {
		new Actions(driver).keyDown(Keys.SHIFT).perform();
	}

	public void shiftKeyUp() {
		new Actions(driver).keyUp(Keys.SHIFT).perform();
	}

	public void metaKeyDown() {
		new Actions(driver).keyDown(Keys.META).perform();
	}

	public void metaKeyUp() {
		new Actions(driver).keyUp(Keys.META).perform();
	}

	public void altKeyDown() {
		new Actions(driver).keyDown(Keys.ALT).perform();
	}

	public void altKeyUp() {
		new Actions(driver).keyUp(Keys.ALT).perform();
	}

	public void controlKeyDown() {
		new Actions(driver).keyDown(Keys.CONTROL).perform();
	}

	public void controlKeyUp() {
		new Actions(driver).keyUp(Keys.CONTROL).perform();
	}

	public void KeyDown(Keys theKey) {
		new Actions(driver).keyDown(theKey).perform();
	}

	public void KeyDown(By by, Keys theKey) {
		new Actions(driver).keyDown(driver.findElement(by), theKey).perform();
	}

	public void KeyUp(Keys theKey) {
		new Actions(driver).keyUp(theKey).perform();
	}

	public void KeyUp(By by, Keys theKey) {
		new Actions(driver).keyUp(driver.findElement(by), theKey).perform();
	}

	public void mouseOver(By by) {
		new Actions(driver).moveToElement(driver.findElement(by)).perform();
	}

	public void mouseOut(By by) {
		System.out.println("没有实现！");
		// new Actions(driver).moveToElement((driver.findElement(by)), -10,
		// -10).perform();
	}

	public void mouseDown(By by) {
		new Actions(driver).clickAndHold(driver.findElement(by)).perform();
	}

	public void mouseDownRight(By by) {
		System.out.println("没有实现！");
	}

	public void mouseDownAt(By by, String coordString) {
		System.out.println("没有实现！");
	}

	public void mouseDownRightAt(By by, String coordString) {
		System.out.println("没有实现！");
	}

	public void mouseUp(By by) {
		System.out.println("没有实现！");
	}

	public void mouseUpRight(By by) {
		System.out.println("没有实现！");
	}

	public void mouseUpAt(By by, String coordString) {
		System.out.println("没有实现！");
	}

	public void mouseUpRightAt(By by, String coordString) {
		System.out.println("没有实现！");
	}

	public void mouseMove(By by) {
		new Actions(driver).moveToElement(driver.findElement(by)).perform();
	}

	public void mouseMoveAt(By by, String coordString) {
		int index = coordString.trim().indexOf(',');
		int xOffset = Integer.parseInt(coordString.trim().substring(0, index));
		int yOffset = Integer.parseInt(coordString.trim().substring(index + 1));
		new Actions(driver).moveToElement(driver.findElement(by), xOffset,
				yOffset).perform();
	}

	public void type(By by, String testdata) {
		driver.findElement(by).clear();
		driver.findElement(by).sendKeys(testdata);
	}

	public void typeKeys(By by, Keys key) {
		driver.findElement(by).sendKeys(key);
	}

	public void setSpeed(String value) {
		System.out
				.println("The methods to set the execution speed in WebDriver were deprecated");
	}

	public String getSpeed() {
		System.out
				.println("The methods to set the execution speed in WebDriver were deprecated");
		return null;

	}

	public void check(By by) {
		if (!isChecked(by))
			click(by);
	}

	public void uncheck(By by) {
		if (isChecked(by))
			click(by);
	}

	public void select(By by, String optionValue) {
		new Select(driver.findElement(by)).selectByValue(optionValue);
	}

	public void select(By by, int index) {
		new Select(driver.findElement(by)).selectByIndex(index);
	}

	public void addSelection(By by, String optionValue) {
		select(by, optionValue);
	}

	public void addSelection(By by, int index) {
		select(by, index);
	}

	public void removeSelection(By by, String value) {
		new Select(driver.findElement(by)).deselectByValue(value);
	}

	public void removeSelection(By by, int index) {
		new Select(driver.findElement(by)).deselectByIndex(index);
	}

	public void removeAllSelections(By by) {
		new Select(driver.findElement(by)).deselectAll();
	}

	public void submit(By by) {
		driver.findElement(by).submit();
	}

	public void open(String url) {
		driver.get(url);
	}

	public void openWindow(String url, String handler) {
		System.out.println("方法没有实现！");
	}

	public void selectWindow(String handler) {
		driver.switchTo().window(handler);
	}

	public String getCurrentHandler() {
		String currentHandler = driver.getWindowHandle();
		return currentHandler;
	}

	public String getSecondWindowHandler() {
		Set<String> handlers = driver.getWindowHandles();
		String reHandler = getCurrentHandler();
		for (String handler : handlers) {
			if (reHandler.equals(handler))
				continue;
			reHandler = handler;
		}
		return reHandler;
	}

	public void selectPopUp(String handler) {
		driver.switchTo().window(handler);
	}

	public void selectPopUp() {
		driver.switchTo().window(getSecondWindowHandler());
	}

	public void deselectPopUp() {
		driver.switchTo().window(getCurrentHandler());
	}

	public void selectFrame(int index) {
		driver.switchTo().frame(index);
	}

	public void selectFrame(String str) {
		driver.switchTo().frame(str);
	}

	public void selectFrame(By by) {
		driver.switchTo().frame(driver.findElement(by));
	}

	public void waitForPopUp(String windowID, String timeout) {
		System.out.println("没有实现");
	}

	public void accept() {
		driver.switchTo().alert().accept();
	}

	public void dismiss() {
		driver.switchTo().alert().dismiss();
	}

	public void chooseCancelOnNextConfirmation() {
		driver.switchTo().alert().dismiss();
	}

	public void chooseOkOnNextConfirmation() {
		driver.switchTo().alert().accept();
	}

	public void answerOnNextPrompt(String answer) {
		driver.switchTo().alert().sendKeys(answer);
	}

	public void goBack() {
		driver.navigate().back();
	}

	public void refresh() {
		driver.navigate().refresh();
	}

	public void forward() {
		driver.navigate().forward();
	}

	public void to(String urlStr) {
		driver.navigate().to(urlStr);
	}

	public void close() {
		driver.close();
	}

	public boolean isAlertPresent() {
		Boolean b = true;
		try {
			driver.switchTo().alert();
		} catch (Exception e) {
			b = false;
		}
		return b;
	}

	public boolean isPromptPresent() {
		return isAlertPresent();
	}

	public boolean isConfirmationPresent() {
		return isAlertPresent();
	}

	public String getAlert() {
		return driver.switchTo().alert().getText();
	}

	public String getConfirmation() {
		return getAlert();
	}

	public String getPrompt() {
		return getAlert();
	}

	public String getLocation() {
		return driver.getCurrentUrl();
	}

	public String getTitle() {
		return driver.getTitle();
	}

	public String getBodyText() {
		String str = "";
		List<WebElement> elements = driver.findElements(By
				.xpath("//body//*[contains(text(),*)]"));
		for (WebElement e : elements) {
			str += e.getText() + " ";
		}
		return str;
	}

	public String getValue(By by) {
		return driver.findElement(by).getAttribute("value");
	}

	public String getText(By by) {
		return driver.findElement(by).getText();
	}

	public void highlight(By by) {
		WebElement element = driver.findElement(by);
		((JavascriptExecutor) driver).executeScript(
				"arguments[0].style.border = \"5px solid yellow\"", element);
	}

	public Object getEval(String script, Object... args) {
		return ((JavascriptExecutor) driver).executeScript(script, args);
	}

	public Object getAsyncEval(String script, Object... args) {
		return ((JavascriptExecutor) driver).executeAsyncScript(script, args);
	}

	public boolean isChecked(By by) {
		return driver.findElement(by).isSelected();
	}

	public String getTable(By by, String tableCellAddress) {
		WebElement table = driver.findElement(by);
		int index = tableCellAddress.trim().indexOf('.');
		int row = Integer.parseInt(tableCellAddress.substring(0, index));
		int cell = Integer.parseInt(tableCellAddress.substring(index + 1));
		List<WebElement> rows = table.findElements(By.tagName("tr"));
		WebElement theRow = rows.get(row);
		String text = getCell(theRow, cell);
		return text;
	}

	private String getCell(WebElement Row, int cell) {
		List<WebElement> cells;
		String text = null;
		if (Row.findElements(By.tagName("th")).size() > 0) {
			cells = Row.findElements(By.tagName("th"));
			text = cells.get(cell).getText();
		}
		if (Row.findElements(By.tagName("td")).size() > 0) {
			cells = Row.findElements(By.tagName("td"));
			text = cells.get(cell).getText();
		}
		return text;

	}

	public String[] getSelectedLabels(By by) {
		Set<String> set = new HashSet<String>();
		List<WebElement> selectedOptions = new Select(driver.findElement(by))
				.getAllSelectedOptions();
		for (WebElement e : selectedOptions) {
			set.add(e.getText());
		}
		return set.toArray(new String[set.size()]);
	}

	public String getSelectedLabel(By by) {
		return getSelectedOption(by).getText();
	}

	public String[] getSelectedValues(By by) {
		Set<String> set = new HashSet<String>();
		List<WebElement> selectedOptions = new Select(driver.findElement(by))
				.getAllSelectedOptions();
		for (WebElement e : selectedOptions) {
			set.add(e.getAttribute("value"));
		}
		return set.toArray(new String[set.size()]);
	}

	public String getSelectedValue(By by) {
		return getSelectedOption(by).getAttribute("value");
	}

	public String[] getSelectedIndexes(By by) {
		Set<String> set = new HashSet<String>();
		List<WebElement> selectedOptions = new Select(driver.findElement(by))
				.getAllSelectedOptions();
		List<WebElement> options = new Select(driver.findElement(by))
				.getOptions();
		for (WebElement e : selectedOptions) {
			set.add(String.valueOf(options.indexOf(e)));
		}
		return set.toArray(new String[set.size()]);
	}

	public String getSelectedIndex(By by) {
		List<WebElement> options = new Select(driver.findElement(by))
				.getOptions();
		return String.valueOf(options.indexOf(getSelectedOption(by)));
	}

	public String[] getSelectedIds(By by) {
		Set<String> ids = new HashSet<String>();
		List<WebElement> options = new Select(driver.findElement(by))
				.getOptions();
		for (WebElement option : options) {
			if (option.isSelected()) {
				ids.add(option.getAttribute("id"));
			}
		}
		return ids.toArray(new String[ids.size()]);
	}

	public String getSelectedId(By by) {
		return getSelectedOption(by).getAttribute("id");
	}

	private WebElement getSelectedOption(By by) {
		WebElement selectedOption = null;
		List<WebElement> options = new Select(driver.findElement(by))
				.getOptions();
		for (WebElement option : options) {
			if (option.isSelected()) {
				selectedOption = option;
			}
		}
		return selectedOption;
	}

	public boolean isSomethingSelected(By by) {
		boolean b = false;
		List<WebElement> options = new Select(driver.findElement(by))
				.getOptions();
		for (WebElement option : options) {
			if (option.isSelected()) {
				b = true;
				break;
			}
		}
		return b;
	}

	public String[] getSelectOptions(By by) {
		Set<String> set = new HashSet<String>();
		List<WebElement> options = new Select(driver.findElement(by))
				.getOptions();
		for (WebElement e : options) {
			set.add(e.getText());
		}
		return set.toArray(new String[set.size()]);
	}

	public String getAttribute(By by, String attributeLocator) {
		return driver.findElement(by).getAttribute(attributeLocator);
	}

	public boolean isTextPresent(String pattern) {
		String Xpath = "//*[contains(text(),\'" + pattern + "\')]";
		try {
			driver.findElement(By.xpath(Xpath));
			return true;
		} catch (NoSuchElementException e) {
			return false;
		}
	}

	public boolean isElementPresent(By by) {
		return driver.findElements(by).size() > 0;
	}

	public boolean isVisible(By by) {
		return driver.findElement(by).isDisplayed();
	}

	public boolean isEditable(By by) {
		return driver.findElement(by).isEnabled();
	}

	public List<WebElement> getAllButtons() {
		return driver.findElements(By.xpath("//input[@type='button']"));
	}

	public List<WebElement> getAllLinks() {
		return driver.findElements(By.tagName("a"));
	}

	public List<WebElement> getAllFields() {
		return driver.findElements(By.xpath("//input[@type='text']"));
	}

	public String[] getAttributeFromAllWindows(String attributeName) {
		System.out.println("不知道怎么实现");
		return null;
	}

	public void dragdrop(By by, String movementsString) {
		dragAndDrop(by, movementsString);
	}

	public void dragAndDrop(By by, String movementsString) {
		int index = movementsString.trim().indexOf('.');
		int xOffset = Integer.parseInt(movementsString.substring(0, index));
		int yOffset = Integer.parseInt(movementsString.substring(index + 1));
		new Actions(driver).clickAndHold(driver.findElement(by)).moveByOffset(
				xOffset, yOffset).perform();
	}

	public void setMouseSpeed(String pixels) {
		System.out.println("不支持");
	}

	public Number getMouseSpeed() {
		System.out.println("不支持");
		return null;
	}

	public void dragAndDropToObject(By source, By target) {
		new Actions(driver).dragAndDrop(driver.findElement(source),
				driver.findElement(target)).perform();
	}

	public void windowFocus() {
		driver.switchTo().defaultContent();
	}

	public void windowMaximize() {
		driver.manage().window().setPosition(new Point(0, 0));
		java.awt.Dimension screenSize = java.awt.Toolkit.getDefaultToolkit()
				.getScreenSize();
		Dimension dim = new Dimension((int) screenSize.getWidth(),
				(int) screenSize.getHeight());
		driver.manage().window().setSize(dim);
	}

	public String[] getAllWindowIds() {
		System.out.println("不能实现！");
		return null;
	}

	public String[] getAllWindowNames() {
		System.out.println("不能实现！");
		return null;
	}

	public String[] getAllWindowTitles() {
		Set<String> handles = driver.getWindowHandles();
		Set<String> titles = new HashSet<String>();
		for (String handle : handles) {
			titles.add(driver.switchTo().window(handle).getTitle());
		}
		return titles.toArray(new String[titles.size()]);
	}

	public String getHtmlSource() {
		return driver.getPageSource();
	}

	public void setCursorPosition(String locator, String position) {
		System.out.println("没能实现！");
	}

	public Number getElementIndex(String locator) {
		System.out.println("没能实现！");
		return null;
	}

	public Object isOrdered(By by1, By by2) {
		System.out.println("没能实现！");
		return null;
	}

	public Number getElementPositionLeft(By by) {
		return driver.findElement(by).getLocation().getX();
	}

	public Number getElementPositionTop(By by) {
		return driver.findElement(by).getLocation().getY();
	}

	public Number getElementWidth(By by) {
		return driver.findElement(by).getSize().getWidth();
	}

	public Number getElementHeight(By by) {
		return driver.findElement(by).getSize().getHeight();
	}

	public Number getCursorPosition(String locator) {
		System.out.println("没能实现！");
		return null;
	}

	public String getExpression(String expression) {
		System.out.println("没能实现！");
		return null;
	}

	public Number getXpathCount(By xpath) {
		return driver.findElements(xpath).size();
	}

	public void assignId(By by, String identifier) {
		System.out.println("不想实现！");
	}

	/*
	 * public void allowNativeXpath(String allow) {
	 * commandProcessor.doCommand("allowNativeXpath", new String[] {allow,}); }
	 */

	/*
	 * public void ignoreAttributesWithoutValue(String ignore) {
	 * commandProcessor.doCommand("ignoreAttributesWithoutValue", new String[]
	 * {ignore,});
	 * 
	 * }
	 */

	public void waitForCondition(String script, String timeout, Object... args) {
		Boolean b = false;
		int time = 0;
		while (time <= Integer.parseInt(timeout)) {
			b = (Boolean) ((JavascriptExecutor) driver).executeScript(script,
					args);
			if (b == true)
				break;
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			time += 1000;
		}
	}

	public void setTimeout(String timeout) {
		driver.manage().timeouts().implicitlyWait(Integer.parseInt(timeout),
				TimeUnit.SECONDS);
	}

	public void waitForPageToLoad(String timeout) {
		driver.manage().timeouts().pageLoadTimeout(Integer.parseInt(timeout),
				TimeUnit.SECONDS);
	}

	public void waitForFrameToLoad(String frameAddress, String timeout) {
		/*
		 * driver.switchTo().frame(frameAddress) .manage() .timeouts()
		 * .pageLoadTimeout(Integer.parseInt(timeout), TimeUnit.SECONDS);
		 */
	}

	public String getCookie() {
		String cookies = "";
		Set<Cookie> cookiesSet = driver.manage().getCookies();
		for (Cookie c : cookiesSet) {
			cookies += c.getName() + "=" + c.getValue() + ";";
		}
		return cookies;
	}

	public String getCookieByName(String name) {
		return driver.manage().getCookieNamed(name).getValue();
	}

	public boolean isCookiePresent(String name) {
		boolean b = false;
		if (driver.manage().getCookieNamed(name) != null
				|| driver.manage().getCookieNamed(name).equals(null))
			b = true;
		return b;
	}

	public void createCookie(Cookie c) {

		driver.manage().addCookie(c);
	}

	public void deleteCookie(Cookie c) {
		driver.manage().deleteCookie(c);
	}

	public void deleteAllVisibleCookies() {
		driver.manage().getCookieNamed("fs").isSecure();
	}

	/*
	 * public void setBrowserLogLevel(String logLevel) {
	 * 
	 * }
	 */

	/*
	 * public void runScript(String script) {
	 * commandProcessor.doCommand("runScript", new String[] {script,}); }
	 */

	/*
	 * public void addLocationStrategy(String strategyName,String
	 * functionDefinition) { commandProcessor.doCommand("addLocationStrategy",
	 * new String[] {strategyName,functionDefinition,}); }
	 */

	public void captureEntirePageScreenshot(String filename) {
		File screenShotFile = ((TakesScreenshot) driver)
				.getScreenshotAs(OutputType.FILE);
		try {
			FileUtils.copyFile(screenShotFile, new File(filename));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/*
	 * public void rollup(String rollupName,String kwargs) {
	 * commandProcessor.doCommand("rollup", new String[] {rollupName,kwargs,});
	 * }
	 * 
	 * public void addScript(String scriptContent,String scriptTagId) {
	 * commandProcessor.doCommand("addScript", new String[]
	 * {scriptContent,scriptTagId,}); }
	 * 
	 * public void removeScript(String scriptTagId) {
	 * commandProcessor.doCommand("removeScript", new String[] {scriptTagId,});
	 * }
	 * 
	 * public void useXpathLibrary(String libraryName) {
	 * commandProcessor.doCommand("useXpathLibrary", new String[]
	 * {libraryName,}); }
	 * 
	 * public void setContext(String context) {
	 * commandProcessor.doCommand("setContext", new String[] {context,}); }
	 */

	/*
	 * public void attachFile(String fieldLocator,String fileLocator) {
	 * commandProcessor.doCommand("attachFile", new String[]
	 * {fieldLocator,fileLocator,}); }
	 */

	/*
	 * public void captureScreenshot(String filename) {
	 * commandProcessor.doCommand("captureScreenshot", new String[]
	 * {filename,}); }
	 */

	public String captureScreenshotToString() {
		String screen = ((TakesScreenshot) driver)
				.getScreenshotAs(OutputType.BASE64);
		return screen;
	}

	/*
	 * public String captureNetworkTraffic(String type) { return
	 * commandProcessor.getString("captureNetworkTraffic", new String[] {type});
	 * }
	 */
	/*
	 * public void addCustomRequestHeader(String key, String value) {
	 * commandProcessor.getString("addCustomRequestHeader", new String[] {key,
	 * value}); }
	 */

	/*
	 * public String captureEntirePageScreenshotToString(String kwargs) { return
	 * commandProcessor.getString("captureEntirePageScreenshotToString", new
	 * String[] {kwargs,}); }
	 */

	public void shutDown() {
		driver.quit();
	}

	/*
	 * public String retrieveLastRemoteControlLogs() { return
	 * commandProcessor.getString("retrieveLastRemoteControlLogs", new String[]
	 * {}); }
	 */

	public void keyDownNative(Keys keycode) {
		new Actions(driver).keyDown(keycode).perform();
	}

	public void keyUpNative(Keys keycode) {
		new Actions(driver).keyUp(keycode).perform();
	}

	public void keyPressNative(String keycode) {
		new Actions(driver).click().perform();
	}

	public void waitForElementPresent(By by) {
		for (int i = 0; i < 60; i++) {
			if (isElementPresent(by)) {
				break;
			} else {
				try {
					driver.wait(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
	}

	public void clickAndWaitForElementPresent(By by, By waitElement) {
		click(by);
		waitForElementPresent(waitElement);
	}

	public Boolean VeryTitle(String exception, String actual) {
		if (exception.equals(actual))
			return true;
		else
			return false;
	}
}