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

import com.bt.om.common.SysConst;
import com.bt.om.entity.Invitation;
import com.bt.om.entity.UserOrder;
import com.bt.om.enums.ResultCode;
import com.bt.om.service.IInvitationService;
import com.bt.om.service.IUserOrderService;
import com.bt.om.vo.web.ResultVo;
import com.bt.om.web.BasicController;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

/**
 * 我要邀请Controller
 */
@Controller
public class InvitationController extends BasicController {
	@Autowired
	private IInvitationService invitationService;
	@Autowired
	private IUserOrderService userOrderService;

	@RequestMapping(value = "/api/invitation.html", method = RequestMethod.GET)
	public String invitation(Model model, HttpServletRequest request) {
		return "search/invitation";
	}

	// 保存邀请信息
	@RequestMapping(value = "/api/saveinvitation", method = RequestMethod.POST)
	@ResponseBody
	public Model saveinvItation(Model model, HttpServletRequest request, HttpServletResponse response) {
		ResultVo<String> result = new ResultVo<>();
		result.setCode(ResultCode.RESULT_SUCCESS.getCode());
		result.setResultDes("");
		model = new ExtendedModelMap();
		String mobileMe = "";
		String mobileFriend = "";

		try {
			InputStream is = request.getInputStream();
			Gson gson = new Gson();
			JsonObject obj = gson.fromJson(new InputStreamReader(is), JsonObject.class);
			mobileMe = obj.get("mobileme").getAsString();
			mobileFriend = obj.get("mobilefriend").getAsString();

			// 我的手机号码必须验证
			if (StringUtils.isEmpty(mobileMe)) {
				result.setResult("1");
				model.addAttribute(SysConst.RESULT_KEY, result);
				return model;
			}
			// 朋友的手机号码必须验证
			if (StringUtils.isEmpty(mobileFriend)) {
				result.setResult("2");
				model.addAttribute(SysConst.RESULT_KEY, result);
				return model;
			}
		} catch (IOException e) {
			result.setCode(ResultCode.RESULT_FAILURE.getCode());
			result.setResultDes("系统繁忙，请稍后再试！");
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}

		Invitation invitation = new Invitation();
		invitation.setInviterMobile(mobileMe);
		invitation.setBeInviterMobile(mobileFriend);
		invitation.setStatus(1);
		
		List<UserOrder> userOrderList = userOrderService.findByMobile(mobileFriend);
		if(userOrderList!=null && userOrderList.size()>0){
			//邀请的用户已经在使用逛鱼搜索
			result.setResult("5");
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}
		
		List<Invitation> invitationExist=invitationService.findByMobileFriend(invitation);
		if(invitationExist == null || invitationExist.size()<0){
			try {
				invitationService.insert(invitation);
			} catch (Exception e) {
				//邀请关系已存在
				result.setResult("3");
				model.addAttribute(SysConst.RESULT_KEY, result);
				return model;
			}
		}else{
			//好友已邀请过我，不能重复邀请
			result.setResult("4");
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}

		result.setResult("0");// 保存成功
		model.addAttribute(SysConst.RESULT_KEY, result);
		return model;
	}
}
