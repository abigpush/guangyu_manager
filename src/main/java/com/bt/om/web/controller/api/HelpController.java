package com.bt.om.web.controller.api;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bt.om.web.BasicController;

/**
 * 逛鱼帮助Controller
 */
@Controller
public class HelpController extends BasicController {

	@RequestMapping(value = "/searchhelp.html", method = RequestMethod.GET)
	public String search(Model model, HttpServletRequest request) {
		return "search/help";
	}
}
