package com.lgu.ccss.common.hang.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping(value = "/api/internal/hang")
public class HangController {
	private static final Logger logger = LoggerFactory.getLogger(HangController.class);
	
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	@ResponseBody
	public String checkHang() {
		return "success";
	}
	
}
