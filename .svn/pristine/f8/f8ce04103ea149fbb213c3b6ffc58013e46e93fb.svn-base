package com.lgu.ccss.admin.stat.carpush.controller;

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
import com.lgu.ccss.admin.stat.carpush.domain.CarPushStatVO;
import com.lgu.ccss.admin.stat.carpush.service.CarPushStatServiceImpl;
import com.lgu.ccss.admin.user.domain.UserVO;
import com.lgu.ccss.admin.user.service.UserServiceImpl;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.PageUtil;


@Controller
@RequestMapping(value = "/stat")
public class CarPushStatController {
	
	@Resource(name = "carPushStatService")
	private CarPushStatServiceImpl carPushStatService;
	
	
	@Autowired
	private PageUtil pageUtil;

	
	
	/**
	 * carPush 전송 이력 리스트 화면
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/carPushStat.do")
	public String carPushStat(HttpServletRequest request, ModelMap model) throws Exception {
		return "/stats/carPushStat";
	}
	
	
	/**
	 *  carPush 전송 이력 리스트 조회
	 * 
	 * @param request
	 * @param carPushStatVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectCarPushStatList.do")
	public Map<String, Object> selectSmsStatList(HttpServletRequest request, CarPushStatVO statVO) throws Exception {

		Map<String, Object> resultMap = carPushStatService.selectCarPushStatList(statVO);
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(statVO.getPage(), pageUtil.getTotalPage(totalCount, statVO.getPageRowCount()), statVO.getPageRowCount(), Constants.GO_SEARCH);
		
		resultMap.put(Constants.PAGING, paging);

		return resultMap;
	}
	
	
	/**
	 * SMS 전송 이력 엑셀 다운로드
	 * 
	 * @param request
	 * @param carPushStatVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectCarPushStatListExcel.do")
	public String selectSmsStatListExcel(HttpServletRequest request,HttpServletResponse resonse, CarPushStatVO statVO ,Model model) throws Exception {
		Map<String, Object> resultMap = carPushStatService.selectCarPushStatListExcel(statVO);
	
		model.addAttribute("resultList", resultMap.get("resultList"));
		model.addAttribute("totalCount", resultMap.get("totalCount"));
		model.addAttribute("startDate", resultMap.get("startDate"));	
		model.addAttribute("endDate", resultMap.get("endDate"));	
		model.addAttribute("msgStatus", resultMap.get("msgStatus"));	
		model.addAttribute("recvPhoneNo", resultMap.get("recvPhoneNo"));	
		model.addAttribute("type", "CarPush_전송이력");
		
		
		return "/excel/stat/carpush/carPushStatListExcel";	
	}
	
	
	
	
	
}
