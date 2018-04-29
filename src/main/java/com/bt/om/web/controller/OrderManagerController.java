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
import org.springframework.web.bind.annotation.ResponseBody;

import com.bt.om.common.SysConst;
import com.bt.om.common.web.PageConst;
import com.bt.om.entity.vo.JqueryDataTable;
import com.bt.om.enums.ResultCode;
import com.bt.om.service.IUserOrderService;
import com.bt.om.vo.web.ResultVo;
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
	 * 跳转到订单查询
	 * @return
	 */
	@RequestMapping(value="/order/list", method=RequestMethod.GET)
	public String toOrderList() {
		
		return PageConst.ORDER_LIST;
	}
	
	/**
	 * 订单管理列表
	 * @return
	 */
	@RequestMapping(value="/load/order/list", method=RequestMethod.GET)
	@ResponseBody
	public JqueryDataTable getOrderList(
			@RequestParam(value="mobile", required=false) String mobile,
			@RequestParam(value="startDate", required=false) String startDate,
			@RequestParam(value="endDate", required=false) String endDate,
			@RequestParam(value="orderStatus", required=false) Integer orderStatus,
			@RequestParam(value="putForwardStatus", required=false) Integer putForwardStatus,
			@RequestParam(value="paymentStatus", required=false) Integer paymentStatus) {
		
		SearchDataVo vo = SearchUtil.getVoForJqueryTab();
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
        int listCount = userOrderService.getAllListCount(vo.getSearchMap());
		if (listCount > 0) {
            List<Map<String, Object>> userOrderList = userOrderService.getAllList(vo);
            vo.setList(userOrderList);
        } else {
            vo.setList(new ArrayList<Map<String, Object>>());
        }
		
		return new JqueryDataTable(vo.getList(), listCount, listCount);
	}

	@RequestMapping(value="/order/status/upt", method=RequestMethod.GET)
    @ResponseBody
	public Model updateOrderStatus ( Model model,
			@RequestParam(value="id", required=false) Integer id,
			@RequestParam(value="orderStatus", required=false) Integer orderStatus,
			@RequestParam(value="putForwardStatus", required=false) Integer putForwardStatus,
			@RequestParam(value="paymentStatus", required=false) Integer paymentStatus) {
		
		ResultVo<String> resultVo = new ResultVo<String>();
		int flag = userOrderService.updateOrderStatus(id, orderStatus, putForwardStatus, paymentStatus);
		if (flag == 0) {
			resultVo.setCode(ResultCode.RESULT_FAILURE.getCode());
			resultVo.setResultDes("修改失败");
			model.addAttribute(SysConst.RESULT_KEY, resultVo);
			return model;
		}
		
		resultVo.setCode(ResultCode.RESULT_SUCCESS.getCode());
		resultVo.setResultDes("成功");
		model.addAttribute(SysConst.RESULT_KEY, resultVo);
		return model;
	}

	@RequestMapping(value="/delete/order", method=RequestMethod.GET)
    @ResponseBody
	public Model deleteOrder ( Model model,
			@RequestParam(value="id", required=false) Integer id) {
		ResultVo<String> resultVo = new ResultVo<String>();
		userOrderService.deleteOrder(id);
		resultVo.setCode(ResultCode.RESULT_SUCCESS.getCode());
		resultVo.setResultDes("成功");
		model.addAttribute(SysConst.RESULT_KEY, resultVo);
		return model;
	}
}
