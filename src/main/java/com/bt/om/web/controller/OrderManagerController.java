package com.bt.om.web.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bt.om.common.web.PageConst;
import com.bt.om.service.IUserOrderService;
import com.bt.om.vo.web.SearchDataVo;
import com.bt.om.web.BasicController;
import com.bt.om.web.util.SearchUtil;

/**
 * 订单管理类
 * @author yuhao
 *
 */
@Controller
public class OrderManagerController extends BasicController{

	@Autowired
	private IUserOrderService userOrderService;
	
	/**
	 * 订单管理列表
	 * @return
	 */
	@RequestMapping(value="/order/list", method=RequestMethod.GET)
	public String getOrderList(Model model,
			@RequestParam(value="mobile", required=false) String mobile,
			@RequestParam(value="startDate", required=false) String startDate,
			@RequestParam(value="endDate", required=false) String endDate,
			@RequestParam(value="orderStatus", required=false) Integer orderStatus,
			@RequestParam(value="putForwardStatus", required=false) Integer putForwardStatus,
			@RequestParam(value="paymentStatus", required=false) Integer paymentStatus) {
		
		SearchDataVo vo = SearchUtil.getVo();
		if(paymentStatus != null) {
			vo.putSearchParam("paymentStatus", paymentStatus+"", paymentStatus);
		}
		if(putForwardStatus != null) {
			vo.putSearchParam("putForwardStatus", putForwardStatus+"", putForwardStatus);
		}
		if(orderStatus != null) {
			vo.putSearchParam("orderStatus", orderStatus+"", orderStatus);
		}
		if(StringUtils.isNotBlank(startDate)) {
			vo.putSearchParam("startDate", startDate, startDate);
		}
		if(StringUtils.isNotBlank(endDate)) {
			vo.putSearchParam("endDate", endDate, endDate);
		}
		if(StringUtils.isNotBlank(mobile)) {
			vo.putSearchParam("mobile", mobile, mobile);
		}

		vo.setCount(userOrderService.getAllListCount(vo.getSearchMap()));
		if (vo.getCount() > 0) {
            List<Map<String, Object>> userOrderList = userOrderService.getAllList(vo);
            vo.setList(userOrderList);
        } else {
            vo.setList(new ArrayList<Map<String, Object>>());
        }
		
		SearchUtil.putToModel(model, vo);
		return PageConst.ORDER_LIST;
	}
	
}
