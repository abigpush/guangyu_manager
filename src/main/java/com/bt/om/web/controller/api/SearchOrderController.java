package com.bt.om.web.controller.api;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.adtime.common.lang.DateUtil;
import com.bt.om.common.SysConst;
import com.bt.om.entity.UserOrder;
import com.bt.om.enums.ResultCode;
import com.bt.om.enums.SessionKey;
import com.bt.om.service.IUserOrderService;
import com.bt.om.util.StringUtil;
import com.bt.om.vo.api.UserOrderVo;
import com.bt.om.vo.web.ResultVo;
import com.bt.om.web.BasicController;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

/**
 * 逛鱼订单搜索Controller
 */
@Controller
public class SearchOrderController extends BasicController {
	@Autowired
	private IUserOrderService userOrderService;

	@RequestMapping(value = "/searchorder.html", method = RequestMethod.GET)
	public String search(Model model, HttpServletRequest request) {
		return "search/searchorder";
	}

	// 查询订单列表
	@RequestMapping(value = "/api/searchorder", method = RequestMethod.POST)
	@ResponseBody
	public Model searchOrder(Model model, HttpServletRequest request, HttpServletResponse response) {
		ResultVo<UserOrderVo> result = new ResultVo<>();
		result.setCode(ResultCode.RESULT_SUCCESS.getCode());
		result.setResultDes("");
		model = new ExtendedModelMap();
		String mobile = "";
		String vcode = "";

		try {
			InputStream is = request.getInputStream();
			Gson gson = new Gson();
			JsonObject obj = gson.fromJson(new InputStreamReader(is), JsonObject.class);
			vcode = obj.get("vcode").getAsString();
			mobile = obj.get("mobile").getAsString();
			// 验证码必须验证
			if (StringUtils.isEmpty(vcode)) {
				result.setResult(new UserOrderVo("", "1"));
				model.addAttribute(SysConst.RESULT_KEY, result);
				return model;
			}
			// 手机号码必须验证
			if (StringUtils.isEmpty(mobile)) {
				result.setResult(new UserOrderVo("", "2"));
				model.addAttribute(SysConst.RESULT_KEY, result);
				return model;
			}
		} catch (IOException e) {
			result.setCode(ResultCode.RESULT_FAILURE.getCode());
			result.setResultDes("系统繁忙，请稍后再试！");
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}

		String sessionCode = request.getSession().getAttribute(SessionKey.SESSION_CODE.toString()) == null ? ""
				: request.getSession().getAttribute(SessionKey.SESSION_CODE.toString()).toString();

		// 验证码有效验证
		if (!vcode.equalsIgnoreCase(sessionCode)) {
			result.setResult(new UserOrderVo("", "3")); // 验证码不一致
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}

		List<UserOrder> userOrderList = userOrderService.selectByMobile(mobile);
		StringBuffer sb = new StringBuffer();
		sb.append("<br/><div class='table'>");
		if (userOrderList != null && userOrderList.size() > 0) {
			double totalCommission=0;
			for(UserOrder userOrder : userOrderList){
				totalCommission=totalCommission+userOrder.getCommission3();
			}
			sb.append("<h2 class='table-caption'>共<font color='red'>" + userOrderList.size() + "</font>条可提现订单，可提现金额<font color='red'>￥"+totalCommission+"</font>：</h2>");
		} else {
			sb.append("<h2 class='table-caption'>无可提现订单或订单处于校验中：</h2>");
		}
		sb.append(
				"<div class='table-column-group'><div class='table-column'></div><div class='table-column'></div><div class='table-column'></div><div class='table-column'></div></div>");
		sb.append(
				"<div class='table-header-group'><ul class='table-row'><li class='table-cell'>商品</li><li class='table-cell'>返利</li><li class='table-cell'>创建时间</li></ul></div>");
		if (userOrderList != null && userOrderList.size() > 0) {
			sb.append("<div class='table-row-group'>");
			for (UserOrder userOrder : userOrderList) {
				sb.append("<ul class='table-row'>");
//				sb.append("<li class='table-cell'>").append("<img height='80' width='80' src='")
//						.append(userOrder.getProductImgUrl()).append("'>").append("</li>");
				sb.append("<li class='table-cell'>" + StringUtil.getSubString(userOrder.getProductInfo(),30) + "</li>");
				sb.append("<li class='table-cell'>￥" + userOrder.getCommission3() + "</li>");
				sb.append("<li class='table-cell'>"
						+ DateUtil.formatDate(userOrder.getCreateTime(), DateUtil.CHINESE_PATTERN) + "</li>");
				sb.append("</ul>");
			}
			sb.append("</div>");
		}
		sb.append("</div>");

		// 这里组装一个msg
		String msg = sb.toString();

		result.setResult(new UserOrderVo(msg, "0"));// 验证码验证成功
		model.addAttribute(SysConst.RESULT_KEY, result);
		return model;
	}
}
