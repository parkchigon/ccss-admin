package com.lgu.ccss.admin.stat.api.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lgu.ccss.admin.stat.api.domain.ApiStatVO;
import com.lgu.ccss.admin.stat.api.service.ApiStatServiceImpl;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.PageUtil;


@Controller
@RequestMapping(value = "/stat")
public class ApiStatController {
	
	@Resource(name = "apiStatService")
	private ApiStatServiceImpl apiStatService;
	
	
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
	@RequestMapping(value = "/apiStat.do")
	public String apiStat(HttpServletRequest request, ModelMap model) throws Exception {
		return "/stats/apiStat";
	}
	
	
	/**
	 * DEVICE_MODEL 조회
	 * 
	 * @param apiStatVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectDeviceModelList.do")
	public Map<String, Object> selectDeviceModelList(HttpServletRequest request, ApiStatVO apiStatVO) throws Exception {
	
		Map<String, Object> resultMap = apiStatService.selectDeviceModelList(apiStatVO);
		
		return resultMap;
	}	
	
	
	/**
	 *  API 사용 이력 리스트 조회
	 * 
	 * @param request
	 * @param apiStatVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectApiStatList.do")
	public Map<String, Object> selectApiStatList(HttpServletRequest request, ApiStatVO apiStatVO) throws Exception {

		Map<String, Object> resultMap = apiStatService.selectApiStatList(apiStatVO);
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(apiStatVO.getPage(), pageUtil.getTotalPage(totalCount, apiStatVO.getPageRowCount()), apiStatVO.getPageRowCount(), Constants.GO_SEARCH);
		
		resultMap.put(Constants.PAGING, paging);

		return resultMap;
	}
	
	
	/**
	 * API 사용 이력 엑셀 다운로드
	 * 
	 * @param request
	 * @param apiStatVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectApiStatListExcel.do")
	public String selectApiStatListExcel(HttpServletRequest request,HttpServletResponse resonse, ApiStatVO apiStatVO ,Model model) throws Exception {
		Map<String, Object> resultMap = apiStatService.selectApiStatListExcel(apiStatVO);
	
		model.addAttribute("resultList", resultMap.get("resultList"));
		model.addAttribute("totalCount", resultMap.get("totalCount"));	
		model.addAttribute("startDate", resultMap.get("startDate"));	
		model.addAttribute("endDate", resultMap.get("endDate"));	
		model.addAttribute("reqCtn", resultMap.get("reqCtn"));	
		model.addAttribute("membId", resultMap.get("membId"));	
		model.addAttribute("resultStatus", resultMap.get("resultStatus"));	
		model.addAttribute("apiNm", resultMap.get("apiNm"));	
		model.addAttribute("deviceType", resultMap.get("deviceType"));	
		model.addAttribute("membNo", resultMap.get("membNo"));
		model.addAttribute("type", "API_사용이력");
		model.addAttribute("deviceModelNm", resultMap.get("deviceModelNm"));
		
		
		return "/excel/stat/api/apiStatListExcel";	
	}
	
	
	
	
	
}
