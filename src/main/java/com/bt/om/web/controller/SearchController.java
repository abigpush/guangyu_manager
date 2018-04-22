package com.bt.om.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bt.om.web.BasicController;

/**
 * 逛鱼搜索Controller
 */
@Controller
public class SearchController extends BasicController {
	@RequestMapping(value = "/search.html", method = RequestMethod.GET)
	public String search(Model model, HttpServletRequest request) {
		return "search/search";
	}
}
