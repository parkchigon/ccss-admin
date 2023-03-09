package com.lgu.ccss.admin.stat.send2car.controller;

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
import com.lgu.ccss.admin.stat.send2car.domain.Send2CarStatVO;
import com.lgu.ccss.admin.stat.send2car.service.Send2CarStatServiceImpl;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.PageUtil;



@Controller
@RequestMapping(value = "/stat")
public class Send2CarStatController {
	
	@Resource(name = "send2CarStatService")
	private Send2CarStatServiceImpl send2CarStatService;
	
	
	@Autowired
	private PageUtil pageUtil;

	
	
	/**
	 * API 사용 이력 리스트 화면
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/send2CarStat.do")
	public String apiStat(HttpServletRequest request, ModelMap model) throws Exception {
		return "/stats/send2CarStat";
	}
	
	
	/**
	 *  Send2Car 사용 이력 리스트 조회
	 * 
	 * @param request
	 * @param apiStatVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectSend2CarStatList.do")
	public Map<String, Object> selectSend2CarStatList(HttpServletRequest request, Send2CarStatVO send2CarStatVO) throws Exception {

		Map<String, Object> resultMap = send2CarStatService.selectSend2CarStatList(send2CarStatVO);
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(send2CarStatVO.getPage(), pageUtil.getTotalPage(totalCount, send2CarStatVO.getPageRowCount()), send2CarStatVO.getPageRowCount(), Constants.GO_SEARCH);
		
		resultMap.put(Constants.PAGING, paging);

		return resultMap;
	}
	

	/**
	 *  Send2Car 사용 이력 상세 조회
	 * 
	 * @param request
	 * @param apiStatVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectSend2CarDetailInfo.do")
	public Map<String, Object> selectSend2CarDetailInfo(HttpServletRequest request, Send2CarStatVO send2CarStatVO) throws Exception {

		Map<String, Object> resultMap = send2CarStatService.selectSend2CarDetailInfo(send2CarStatVO);
		return resultMap;
	}
	
	
	/**
	 * send2Car 사용 이력 엑셀 다운로드
	 * 
	 * @param request
	 * @param apiStatVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectSend2CarStatListExcel.do")
	public String selectSend2CarStatListExcel(HttpServletRequest request,HttpServletResponse resonse, Send2CarStatVO send2CarStatVO ,Model model) throws Exception {
		Map<String, Object> resultMap = send2CarStatService.selectSend2CarStatListExcel(send2CarStatVO);
	
		model.addAttribute("resultList", resultMap.get("resultList"));
		model.addAttribute("totalCount", resultMap.get("totalCount"));	
		model.addAttribute("startDate", resultMap.get("startDate"));	
		model.addAttribute("endDate", resultMap.get("endDate"));	
		
		model.addAttribute("membId", resultMap.get("membId"));	
		model.addAttribute("deviceCtn", resultMap.get("deviceCtn"));	
		model.addAttribute("mgrappCtn", resultMap.get("mgrappCtn"));
		model.addAttribute("mgrappLoginId", resultMap.get("mgrappLoginId"));	
		model.addAttribute("sendStatus", resultMap.get("sendStatus"));	
		model.addAttribute("serviceType", resultMap.get("serviceType"));
		model.addAttribute("type", "SEND2CAR_사용이력");
		
		return "/excel/stat/send2Car/send2CarStatListExcel";	
	}
	
	
	
	
	
}
