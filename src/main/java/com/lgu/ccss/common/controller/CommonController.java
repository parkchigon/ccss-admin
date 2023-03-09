package com.lgu.ccss.common.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CommonController {

    @RequestMapping("/Relay.do")
    public String relay(Model model) throws Exception {
        return "common/Relay";
    }

    @RequestMapping("/HistoryBack.do")
    public String historyBack(Model model) throws Exception {
        return "common/HistoryBack";
    }

    @RequestMapping("/common/error/500")
    public String error500(Model model) throws Exception {
        return "common/error/500";
    }

    @RequestMapping("/common/error/404")
    public String error404(Model model) throws Exception {
        return "common/error/404";
    }
    
    @RequestMapping("/common/error/401")
    public String error401(Model model) throws Exception {
        return "common/error/401";
    }
    
	@RequestMapping(value="/check/hang")
	@ResponseBody
	public String checkHang(HttpServletRequest request) throws Exception {
		return "success";
	}
	
	/** 예외 시험용 */
	@RequestMapping(value = "/check/hang/test")
	@ResponseBody
	public String checkHangTest(HttpServletRequest request) throws Exception {
		Thread.sleep(40000);
		return "success";
	}
}
