package com.bt.om.task;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.bt.om.entity.TkOrderInput;
import com.bt.om.entity.UserOrder;
import com.bt.om.service.ITkOrderInputService;
import com.bt.om.service.IUserOrderService;
import com.bt.om.util.ConfigUtil;

@Component
public class UserOrderCheckTask {
	private static final Logger logger = Logger.getLogger(UserOrderCheckTask.class);
	@Autowired
	private IUserOrderService userOrderService;
	@Autowired
	private ITkOrderInputService tkOrderInputService;

	// 每隔一段时间进行一次订单校验
	@Scheduled(cron = "0 0 */5 * * ?")
	public void userOrderCheck() {
		logger.info("用户订单定时校验");
		UserOrder userOrder = new UserOrder();
		List<UserOrder> userOrderList = userOrderService.selectUnCheckByMobile(userOrder);
		if (userOrderList != null && userOrderList.size() > 0) {
			logger.info("共有"+userOrderList.size()+"条商品未校验");
			for (UserOrder userOrder1 : userOrderList) {
				TkOrderInput tkOrderInput = tkOrderInputService.selectByOrderId(userOrder1.getOrderId());
				if (tkOrderInput != null) {
					logger.info("更新用户订单"+userOrder1.getOrderId()+"信息");
					userOrder1.setPrice(tkOrderInput.getPrice());
					userOrder1.setRate(tkOrderInput.getCommissionRate());
					userOrder1.setShopName(tkOrderInput.getShopName());
					userOrder1.setProductInfo(tkOrderInput.getProductInfo());
					userOrder1.setCommission1(tkOrderInput.getCommissionMoney());
					userOrder1.setCommission2(tkOrderInput.getCommissionMoney() * 0.8);
					userOrder1.setCommission3(((double) (Math
							.round(tkOrderInput.getCommissionMoney() * ConfigUtil.getFloat("commission.rate", 1) * 100))
							/ 100));
					userOrder1.setStatus1(2);
					userOrder1.setUpdateTime(new Date());
					userOrderService.updateByPrimaryKey(userOrder1);
				}else{
					logger.info("订单"+userOrder1.getOrderId()+"为从阿里妈妈导入、或订单不存在");
				}
			}
		}else{
			logger.info("所有商品已校验");
		}

	}

	public static void main(String[] args) throws Exception {
		String[] cfgs = new String[] { "classpath:spring/applicationContext.xml" };
		ApplicationContext ctx = new ClassPathXmlApplicationContext(cfgs);
		((UserOrderCheckTask) ctx.getBean("userOrderCheckTask")).userOrderCheck();
	}
}
