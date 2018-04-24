package com.bt.om.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bt.om.common.web.PageConst;
import com.bt.om.web.BasicController;

/**
 * 订单管理类
 * @author yuhao
 *
 */
@Controller
public class OrderManagerController extends BasicController{

	/**
	 * 
	 * @return
	 */
	@RequestMapping(value="/order/list", method=RequestMethod.GET)
	public String getOrderList() {
		
		
		return PageConst.ORDER_LIST;
	}
	
}
