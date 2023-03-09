package com.lgu.ccss.admin.app.controller;


import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lgu.ccss.admin.app.domain.AppVO;
import com.lgu.ccss.admin.app.service.AppServiceImpl;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.PageUtil;
import com.lgu.ccss.common.utility.SessionUtil;

@Controller
public class AppController {
	
	@Resource(name = "appService")
	private AppServiceImpl appService;
	
	@Autowired
	private PageUtil pageUtil;
	
	/**
	 * APP 버전 리스트화면
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/app/appList.do")
	public String appList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		return "/app/appList";
	}
	
	
	/**
	 * App 리스트 조회  리스트 5개 
	 * 
	 * @param request
	 * @param response
	 * @param appVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/app/selectAppList.do", method = RequestMethod.POST)
	public Map<String, Object> selectAppList(HttpServletRequest request, HttpServletResponse response, AppVO appVO) throws Exception {

		appVO.setPageRowCount(Constants.PAGING_CNT_FIVE);
		Map<String, Object> resultMap = appService.selectAppList(appVO);
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(appVO.getPage(), pageUtil.getTotalPage(totalCount, appVO.getPageRowCount()), appVO.getPageRowCount(), Constants.GO_SEARCH);
		
		resultMap.put(Constants.PAGING, paging);

		return resultMap;
	}
	
	/**
	 * APP 정보 삭제
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/app/deleteApp.do")
	public Map<String, Object> deleteApp(HttpServletRequest request, HttpServletResponse response, AppVO appVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap   = appService.deleteApp(appVO);
		return resultMap;
	}
	
	
	/**
	 * App버전 등록 화면
	 * 
	 * @param request
	 * @param response
	 * @param appVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/app/appInsertForm.do")
	public String appInsertForm(HttpServletRequest request, HttpServletResponse response, AppVO appVO, ModelMap model) throws Exception {
		return "/app/appInsertForm";
	}
	
	
	/**
	 * App 정보 수정 화면
	 * 
	 * @param request
	 * @param response
	 * @param appVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/app/appEditForm.do")
	public String gunbamAppEditForm(HttpServletRequest request, HttpServletResponse response, AppVO appVO, ModelMap model) throws Exception {
		appVO = appService.selectAppDetail(appVO);
		model.addAttribute("appVO", appVO);
		return "/app/appEditForm";
	}
	
	/**
	 * 신규 App 정보 등록
	 * @param request
	 * @param response
	 * @param appVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/app/insertNewApp.do")
	public Map<String, Object> insertNewApp(HttpServletRequest request, HttpServletResponse response, AppVO appVO) throws Exception {
	
		appVO.setRegId(SessionUtil.getLoginId(request));
		appVO.setUpdId(SessionUtil.getLoginId(request));
		Map<String, Object> resultMap = appService.insertNewApp(appVO);
	
		return resultMap;
	}
	
	/**
	 * App정보 상세 화면
	 * 
	 * @param request
	 * @param response
	 * @param appVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/app/appDetail.do")
	public String selectAppDetail(HttpServletRequest request, HttpServletResponse response, AppVO appVO, ModelMap model) throws Exception {
		appVO = appService.selectAppDetail(appVO);
		model.addAttribute("appVO", appVO);
		return "/app/appDetail";
	}
	
	
	/**
	 * App 정보 수정
	 * 
	 * @param request
	 * @param response
	 * @param appVO
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/app/updateApp.do")
	public Map<String, Object> updateApp(HttpServletRequest request, HttpServletResponse response, AppVO appVO) throws Exception {
		appVO.setUpdId(SessionUtil.getLoginId(request));
		Map<String, Object> resultMap = appService.updateApp(appVO);
		return resultMap;
	}
	
}

