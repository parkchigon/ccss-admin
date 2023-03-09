package com.lgu.ccss.admin.stat.sms.controller;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lgu.ccss.admin.product.domain.ProductVO;
import com.lgu.ccss.admin.product.service.ProductServiceImpl;
import com.lgu.ccss.admin.stat.api.domain.ApiStatVO;
import com.lgu.ccss.admin.stat.api.service.ApiStatServiceImpl;
import com.lgu.ccss.admin.stat.sms.domain.SmsStatVO;
import com.lgu.ccss.admin.stat.sms.service.SmsStatServiceImpl;
import com.lgu.ccss.admin.user.domain.UserVO;
import com.lgu.ccss.admin.user.service.UserServiceImpl;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.PageUtil;


@Controller
@RequestMapping(value = "/stat")
public class SmsStatController {
	
	@Resource(name = "smsStatService")
	private SmsStatServiceImpl smsStatService;
	
	
	@Autowired
	private PageUtil pageUtil;

	
	
	/**
	 * SMS 전송 이력 리스트 화면
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/smsStat.do")
	public String smsStat(HttpServletRequest request, ModelMap model) throws Exception {
		return "/stats/smsStat";
	}
	
	
	/**
	 *  SMS 전송 이력 리스트 조회
	 * 
	 * @param request
	 * @param smsStatVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectSmsStatList.do")
	public Map<String, Object> selectSmsStatList(HttpServletRequest request, SmsStatVO smsStatVO) throws Exception {

		Map<String, Object> resultMap = smsStatService.selectSmsStatList(smsStatVO);
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(smsStatVO.getPage(), pageUtil.getTotalPage(totalCount, smsStatVO.getPageRowCount()), smsStatVO.getPageRowCount(), Constants.GO_SEARCH);
		
		resultMap.put(Constants.PAGING, paging);

		return resultMap;
	}
	
	
	/**
	 * SMS 전송 이력 엑셀 다운로드
	 * 
	 * @param request
	 * @param smsStatVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectSmsStatListExcel.do")
	public String selectSmsStatListExcel(HttpServletRequest request,HttpServletResponse resonse, SmsStatVO smsStatVO ,Model model) throws Exception {
		Map<String, Object> resultMap = smsStatService.selectSmsStatListExcel(smsStatVO);
	
		model.addAttribute("resultList", resultMap.get("resultList"));
		model.addAttribute("totalCount", resultMap.get("totalCount"));
		model.addAttribute("startDate", resultMap.get("startDate"));	
		model.addAttribute("endDate", resultMap.get("endDate"));	
		model.addAttribute("msgStatus", resultMap.get("msgStatus"));	
		model.addAttribute("recvPhoneNo", resultMap.get("recvPhoneNo"));	
		model.addAttribute("type", "SMS_전송이력");
		
		
		return "/excel/stat/sms/smsStatListExcel";	
	}
	
	
	
	
	
}
