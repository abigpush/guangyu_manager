package com.bt.om.selenium;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

import com.bt.om.common.ServiceLocator;
import com.bt.om.entity.TkInfoTask;
import com.bt.om.queue.disruptor.DisruptorQueueImpl;
import com.bt.om.selenium.util.PageUtils;
import com.bt.om.service.ITkInfoTaskService;
import com.bt.om.service.impl.TkInfoTaskService;
import com.bt.om.util.ConfigUtil;
import com.bt.om.util.NumberUtil;
import com.lmax.disruptor.BlockingWaitStrategy;
import com.lmax.disruptor.dsl.ProducerType;

public class ProductUrlTrans {
	private static final Logger logger = Logger.getLogger(ProductUrlTrans.class);
	
	private static final ScheduledExecutorService scheduler = Executors
			.newScheduledThreadPool(1);

	private static ITkInfoTaskService tkInfoTaskService = ServiceLocator.getService(TkInfoTaskService.class);

//	private static String key = "webdriver.chrome.driver";
//	private static String value = ".\\conf\\tools\\chromedriver.exe";
	private static String key = ConfigUtil.getString("selenium.drive.name");
	private static String value = ConfigUtil.getString("selenium.drive.path");
	private static WebDriver driver;
	private static String baseUrl = "https://pub.alimama.com/promo/search/index.htm";

	private static int sleepTimeBegin = 1000;
	private static int sleepTimeEnd = 1500;

	final static DisruptorQueueImpl queue = new DisruptorQueueImpl("name", ProducerType.SINGLE, 1024,
			new BlockingWaitStrategy());

	static {
		init();
		schedule();
		System.setProperty(key, value);
//		driver = new ChromeDriver();
		driver = new FirefoxDriver();
		driver.get(baseUrl);
		driver.manage().timeouts().implicitlyWait(2, TimeUnit.SECONDS);
	}

	public static void init() {
		Thread consumer = new Thread(new Runnable() {// 消费者
			@Override
			public void run() {
				while (true) {
					try {
						TkInfoTask tkInfoTask = (TkInfoTask) queue.take();
						logger.info("consumer..");
						getTKUrl(tkInfoTask);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		});
		consumer.start();
	}

	public static WebDriver getDriver() {
		return driver;
	}

	public static void put(TkInfoTask tkInfoTask) {
		logger.info("publish..");
		queue.publish(tkInfoTask);
	}

	private static void getTKUrl(TkInfoTask tkInfoTask) throws Exception {
		driver.findElement(By.id("q")).clear();
		driver.findElement(By.id("q")).sendKeys(tkInfoTask.getProductUrl());
		driver.findElement(By.xpath("//div[@id='magix_vf_header']/div/div/div[2]/div[2]/button")).click();
        //点击搜索按钮后sleep
		Thread.sleep(NumberUtil.getRandomNumber(sleepTimeBegin, sleepTimeEnd));
		
		//滚动到图片元素
		WebElement element0 = driver.findElement(By.xpath("//*[@id='J_search_results']/div/div/div[1]/a/img"));
		PageUtils.scrollToElementAndPick(element0, driver);
		
		String productImgUrl = driver.findElement(By.xpath("//*[@id='J_search_results']/div/div/div[1]/a/img"))
				.getAttribute("src");
//		String price = driver.findElement(By.xpath("//*[@id='J_search_results']/div/div/div[2]/div[3]/span[1]/span[2]"))
//				.getText() + "."
//				+ driver.findElement(By.xpath("//*[@id='J_search_results']/div/div/div[2]/div[3]/span[1]/span[4]"))
//						.getText();
		String price="123";
		String sales = driver
				.findElement(By.xpath("//*[@id='J_search_results']/div/div/div[2]/div[3]/span[2]/span[2]/span"))
				.getText();
		String commision = driver
				.findElement(By.xpath("//*[@id='J_search_results']/div/div/div[2]/div[4]/span[2]/span[2]/span[2]"))
				.getText()
				+ "."
				+ driver.findElement(
						By.xpath("//*[@id='J_search_results']/div/div/div[2]/div[4]/span[2]/span[2]/span[4]"))
						.getText();
		String rate = driver
				.findElement(By.xpath("//*[@id='J_search_results']/div/div/div[2]/div[4]/span[1]/span[2]/span[1]"))
				.getText()
				+ "."
				+ driver.findElement(
						By.xpath("//*[@id='J_search_results']/div/div/div[2]/div[4]/span[1]/span[2]/span[3]"))
						.getText();

		tkInfoTask.setProductImgUrl(productImgUrl);
		tkInfoTask.setPrice(Double.valueOf(price.replace(",", "")));
		tkInfoTask.setSales(Integer.parseInt(sales));
		tkInfoTask.setCommision(Double.valueOf(commision));
		tkInfoTask.setRate(Double.valueOf(rate));

		// 点击立即推广按钮		
		WebElement element1 = driver.findElement(By.linkText("立即推广"));
		PageUtils.scrollToElementAndClick(element1, driver);

		// 点击确定按钮
		Thread.sleep(NumberUtil.getRandomNumber(sleepTimeBegin, sleepTimeEnd));
		WebElement element2 = driver.findElement(By.xpath("//div[@id='J_global_dialog']/div/div[3]/button"));
		PageUtils.scrollToElementAndClick(element2, driver);

		// 点击复制按钮
		// Thread.sleep(2000);
		// WebElement
		// element3=driver.findElement(By.xpath("(//button[@type='button'])[6]"));
		// PageUtils.scrollToElementAndClick(element3, driver);
		String tkurl = "";
		String quanurl = "";
		try {
			tkurl = driver.findElement(By.id("clipboard-target-1")).getAttribute("value");
			quanurl = driver.findElement(By.id("clipboard-target-2")).getAttribute("value");
		} catch (Exception e) {
			tkurl = driver.findElement(By.xpath("//*[@id='clipboard-target']")).getAttribute("value");
		}

		// 点击淘口令按钮
		Thread.sleep(NumberUtil.getRandomNumber(sleepTimeBegin, sleepTimeEnd));
		WebElement element3 = driver.findElement(By.xpath("//*[@id='magix_vf_code']/div/div[1]/ul/li[4]"));
		PageUtils.scrollToElementAndClick(element3, driver);

		String tcode = "";
		String quancode = "";

		try {
			tcode = driver.findElement(By.xpath("//*[@id='clipboard-target-1']")).getAttribute("value");
			quancode = driver.findElement(By.xpath("//*[@id='clipboard-target-2']")).getAttribute("value");

			// 点击关闭按钮
			Thread.sleep(NumberUtil.getRandomNumber(sleepTimeBegin, sleepTimeEnd));
			WebElement element4 = driver.findElement(By.xpath("//div[@id='magix_vf_code']/div/div[3]/button"));
			PageUtils.scrollToElementAndClick(element4, driver);
		} catch (Exception e) {
			tcode = driver.findElement(By.xpath("//*[@id='clipboard-target']")).getAttribute("value");

			// 点击关闭按钮
			Thread.sleep(NumberUtil.getRandomNumber(sleepTimeBegin, sleepTimeEnd));
			WebElement element4 = driver.findElement(By.xpath("//*[@id='magix_vf_code']/div/div[3]/button[2]"));
			PageUtils.scrollToElementAndClick(element4, driver);

		}

		tkInfoTask.setTkurl(tkurl);
		tkInfoTask.setQuanUrl(quanurl);
		tkInfoTask.setTcode(tcode);
		tkInfoTask.setQuanCode(quancode);

		tkInfoTaskService.insertTkInfoTask(tkInfoTask);
	}
	
	private static void schedule() {
		// 延迟3-5分钟，间隔3-5分钟执行
		scheduler.scheduleAtFixedRate(new Runnable() {
			@Override
			public void run() {
				try {
					logger.info("refresh...");		
					driver.navigate().refresh();
				} catch (Exception e) {
					logger.error("refresh error:[{}]", e);
				}
			}
		}, NumberUtil.getRandomNumber(5, 10), NumberUtil.getRandomNumber(5, 10), TimeUnit.MINUTES);
	}
}
