package com.bt.om.web.controller.api;

import com.bt.om.cache.JedisPool;
import com.bt.om.common.SysConst;
import com.bt.om.entity.ProductInfo;
import com.bt.om.entity.User;
import com.bt.om.enums.ResultCode;
import com.bt.om.enums.SessionKey;
import com.bt.om.service.IProductInfoService;
import com.bt.om.service.IUserService;
import com.bt.om.util.ConfigUtil;
import com.bt.om.util.StringUtil;
import com.bt.om.util.TaobaoSmsUtil;
import com.bt.om.vo.api.GetSmsCodeVo;
import com.bt.om.vo.api.ProductCommissionVo;
import com.bt.om.vo.api.ProductInfoVo;
import com.bt.om.vo.api.UserVo;
import com.bt.om.vo.web.ResultVo;
import com.bt.om.web.BasicController;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api")
public class ApiController extends BasicController {
	@Autowired
	private IUserService userService;

	@Autowired
	private IProductInfoService productInfoService;

	// @Autowired
	// private JedisService jedisService;

	@Autowired
	private JedisPool jedisPool;

	// 获取验证码
	@RequestMapping(value = "/getSmsCode", method = RequestMethod.POST)
	@ResponseBody
	public Model getSmsCode(Model model, HttpServletRequest request, HttpServletResponse response) {
		ResultVo<GetSmsCodeVo> result = new ResultVo<>();
		result.setCode(ResultCode.RESULT_SUCCESS.getCode());
		result.setResultDes("获取验证码成功");
		model = new ExtendedModelMap();
		String mobile = null;
		try {
			InputStream is = request.getInputStream();
			Gson gson = new Gson();
			JsonObject obj = gson.fromJson(new InputStreamReader(is), JsonObject.class);
			mobile = obj.get("mobile").getAsString();
		} catch (IOException e) {
			result.setCode(ResultCode.RESULT_FAILURE.getCode());
			result.setResultDes("系统繁忙，请稍后再试！");
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}

		// 手机号验证
		if (StringUtils.isEmpty(mobile)) {
			result.setCode(ResultCode.RESULT_FAILURE.getCode());
			result.setResultDes("手机号为必填！");
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}

		// User user = userService.getByMobile(mobile);
		// if (user != null) {
		// result.setCode(ResultCode.RESULT_FAILURE.getCode());
		// result.setResultDes("该手机号已注册！");
		// model.addAttribute(SysConst.RESULT_KEY, result);
		// return model;
		// }

		String vcode = getVcode(5);
		System.out.println(vcode);
		// jedisService.putInCache("gy", "vcode", vcode, 60);
		jedisPool.getResource().setex(mobile, 60, vcode);

		// 发送短信验证码
		if ("on".equals(ConfigUtil.getString("is.sms.send"))) {
			TaobaoSmsUtil.sendSms("逛鱼返利", "SMS_125955002", vcode, mobile);
		}

		// System.out.println(jedisPool.getResource().get("vcode"));

		result.setResult(new GetSmsCodeVo(vcode));
		model.addAttribute(SysConst.RESULT_KEY, result);
		// response.getHeaders().add("Access-Control-Allow-Credentials","true");
		response.setHeader("Access-Control-Allow-Origin", request.getHeader("origin"));
		response.setHeader("Access-Control-Allow-Credentials", "true");

		return model;
	}

	// 登录
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	public Model login(Model model, HttpServletRequest request, HttpServletResponse response) {
		ResultVo<UserVo> result = new ResultVo<>();
		result.setCode(ResultCode.RESULT_SUCCESS.getCode());
		result.setResultDes("登录成功");
		model = new ExtendedModelMap();
		String mobile = null;
		String vcode = null;

		try {
			InputStream is = request.getInputStream();
			Gson gson = new Gson();
			JsonObject obj = gson.fromJson(new InputStreamReader(is), JsonObject.class);
			mobile = obj.get("mobile").getAsString();
			vcode = obj.get("vcode").getAsString();
		} catch (IOException e) {
			result.setCode(ResultCode.RESULT_FAILURE.getCode());
			result.setResultDes("系统繁忙，请稍后再试！");
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}

		// 账户必须验证
		if (StringUtils.isEmpty(mobile)) {
			result.setCode(ResultCode.RESULT_FAILURE.getCode());
			result.setResultDes("用户名为必填！");
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}

		// 验证码必须验证
		if (StringUtils.isEmpty(vcode)) {
			result.setCode(ResultCode.RESULT_FAILURE.getCode());
			result.setResultDes("验证码为必填！");
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}

		String inVcode = jedisPool.getResource().get(mobile);
		System.out.println(inVcode);
		if (inVcode == null) {
			result.setCode(ResultCode.RESULT_FAILURE.getCode());
			result.setResultDes("验证码已失效！");
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}
		User user = null;
		if (vcode.equals(inVcode)) {
			user = userService.getByMobile(mobile);
			String md5Mobile = new Md5Hash(mobile).toString();
			if (user == null) {
				user = new User();
				user.setMobile(mobile);
				user.setUserId(md5Mobile);
				int userId = userService.insert(user);
				user.setId(userId);
			}
		} else {
			result.setCode(ResultCode.RESULT_FAILURE.getCode());
			result.setResultDes("手机号或验证码有误！");
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}

		result.setResult(new UserVo(user));
		model.addAttribute(SysConst.RESULT_KEY, result);
		// response.getHeaders().add("Access-Control-Allow-Credentials","true");
		response.setHeader("Access-Control-Allow-Origin", request.getHeader("origin"));
		response.setHeader("Access-Control-Allow-Credentials", "true");
		return model;
	}

	// 获取商品详情
	@RequestMapping(value = "/productInfo", method = RequestMethod.POST)
	@ResponseBody
	public Model productInfo(Model model, HttpServletRequest request, HttpServletResponse response) {
		ResultVo<ProductInfoVo> result = new ResultVo<>();
		result.setCode(ResultCode.RESULT_SUCCESS.getCode());
		result.setResultDes("商品信息获取成功");
		model = new ExtendedModelMap();
		@SuppressWarnings("unused")
		String user_id;
		String product_url = "";
		try {
			InputStream is = request.getInputStream();
			Gson gson = new Gson();
			JsonObject obj = gson.fromJson(new InputStreamReader(is), JsonObject.class);
			user_id = obj.get("user_id").getAsString();

			product_url = obj.get("product_url").getAsString();
		} catch (IOException e) {
			result.setCode(ResultCode.RESULT_FAILURE.getCode());
			result.setResultDes("系统繁忙，请稍后再试！");
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}

		// 商品链接验证
		if (StringUtils.isEmpty(product_url)) {
			result.setCode(ResultCode.RESULT_FAILURE.getCode());
			result.setResultDes("商品链接为空！");
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}

		Map<String, String> urlMap = StringUtil.urlSplit(product_url);

		// 判断链接中是否有ID
		if (StringUtils.isEmpty(urlMap.get("id"))) {
			result.setCode(ResultCode.RESULT_FAILURE.getCode());
			result.setResultDes("商品ID为空！");
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}

		ProductInfo productInfo = productInfoService.getByProductId(urlMap.get("id"));
		// if (productInfo == null) {
		// result.setCode(ResultCode.RESULT_FAILURE.getCode());
		// result.setResultDes("商品信息不存在！");
		// model.addAttribute(SysConst.RESULT_KEY, result);
		// return model;
		// }
		if (productInfo == null) {
			productInfo = new ProductInfo();
			CrawlTask crawlTask = new CrawlTask();
			TaskBean taskBean = crawlTask.getProduct(product_url);
			if (StringUtils.isNotEmpty(taskBean.getMap().get("goodUrl1"))
					|| StringUtils.isNotEmpty(taskBean.getMap().get("goodUrl2"))) {
				String goodUrl = StringUtils.isEmpty(taskBean.getMap().get("goodUrl1"))
						? taskBean.getMap().get("goodUrl2") : taskBean.getMap().get("goodUrl1");
				productInfo.setProductId(urlMap.get("id"));
				productInfo.setProductImgUrl("http://" + taskBean.getMap().get("img"));
				productInfo.setProductInfoUrl(taskBean.getMap().get("url"));
				productInfo.setShopName(taskBean.getMap().get("shop"));
				productInfo.setProductName(taskBean.getMap().get("title"));
				productInfo.setTkLink(goodUrl);
				productInfo.setPrice(Double.valueOf(taskBean.getMap().get("price").replace("￥", "").replace(",", "")));
				productInfo.setIncomeRate(Float.valueOf(taskBean.getMap().get("per").replace("%", "")));
				productInfo.setCommission(Float.valueOf(taskBean.getMap().get("money").replace("￥", "")));
				productInfo.setCouponLink(taskBean.getMap().get("quanUrl"));
				productInfo.setCreateTime(new Date());
				productInfo.setUpdateTime(new Date());
				productInfoService.insertProductInfo(productInfo);
			} else {
				return model;
			}
		}

		result.setResult(new ProductInfoVo(productInfo.getTkLink(), "领券", productInfo.getCouponLink()));
		model.addAttribute(SysConst.RESULT_KEY, result);
		// response.getHeaders().add("Access-Control-Allow-Credentials","true");
		response.setHeader("Access-Control-Allow-Origin", request.getHeader("origin"));
		response.setHeader("Access-Control-Allow-Credentials", "true");

		return model;
	}

	// 佣金信息获取请求
	@RequestMapping(value = "/getCommission", method = RequestMethod.POST)
	@ResponseBody
	public Model getCommission(Model model, HttpServletRequest request, HttpServletResponse response) {
		ResultVo<ProductCommissionVo> result = new ResultVo<>();
		result.setCode(ResultCode.RESULT_SUCCESS.getCode());
		result.setResultDes("商品折扣信息获取成功");
		model = new ExtendedModelMap();
		@SuppressWarnings("unused")
		String user_id;
		String num_iids = "";
		try {
			InputStream is = request.getInputStream();
			Gson gson = new Gson();
			JsonObject obj = gson.fromJson(new InputStreamReader(is), JsonObject.class);
			user_id = obj.get("user_id").getAsString();
			num_iids = obj.get("num_iids").getAsString();
		} catch (IOException e) {
			result.setCode(ResultCode.RESULT_FAILURE.getCode());
			result.setResultDes("系统繁忙，请稍后再试！");
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}

		// 商品ID验证
		if (StringUtils.isEmpty(num_iids)) {
			result.setCode(ResultCode.RESULT_FAILURE.getCode());
			result.setResultDes("商品ID为空！");
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}
		List<String> num_iids_list = java.util.Arrays.asList(num_iids.split(","));

		Map<String, Object> productIdsMap = new HashMap<>();
		List<String> list = new ArrayList<>();
		for (String productId : num_iids_list) {
			list.add(productId);
		}
		productIdsMap.put("list", list);

		List<ProductInfo> productInfoList = productInfoService.getByProductIds(productIdsMap);

		int productListSize = 0;
		if (productInfoList == null || productInfoList.size() <= 0) {
			// result.setCode(ResultCode.RESULT_FAILURE.getCode());
			// result.setResultDes("商品信息不存在！");
			// model.addAttribute(SysConst.RESULT_KEY, result);
			// return model;

		} else {
			productListSize = productInfoList.size();
		}
		System.out.println(productInfoList.size());

		// 商品佣金一一对应
		List<Float> commissionList = new ArrayList<>();
		for (String productId : num_iids_list) {
			int size = 0;
			if (productListSize > 0) {
				for (ProductInfo productInfo : productInfoList) {
					if (productId.equals(productInfo.getProductId())) {
						commissionList.add(productInfo.getCommission());
						break;
					} else {
						size = size + 1;
					}
				}
				if (size == productInfoList.size()) {
					commissionList.add(0f);
				}
			} else {
				commissionList.add(0f);
			}
		}

		String commissions = "";
		Float[] commissionArr = commissionList.toArray(new Float[commissionList.size()]);
		commissions = StringUtils.join(commissionArr, ",");
		System.out.println(commissions);

		result.setResult(new ProductCommissionVo(commissions));
		model.addAttribute(SysConst.RESULT_KEY, result);
		// response.getHeaders().add("Access-Control-Allow-Credentials","true");
		response.setHeader("Access-Control-Allow-Origin", request.getHeader("origin"));
		response.setHeader("Access-Control-Allow-Credentials", "true");

		return model;
	}

	/**
	 * 根据位数生成验证码
	 * 
	 * @param size
	 *            位数
	 * @return
	 */
	public String getVcode(int size) {
		String retNum = "";
		// 定义验证码的范围
		// String codeStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
		String codeStr = "1234567890";

		Random r = new Random();
		for (int i = 0; i < size; i++) {
			retNum += codeStr.charAt(r.nextInt(codeStr.length()));
		}
		return retNum;
	}
}
