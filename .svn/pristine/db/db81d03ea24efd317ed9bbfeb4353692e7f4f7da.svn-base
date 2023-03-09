package com.lgu.ccss.admin.system.program.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.lgu.ccss.admin.system.menu.domain.MenuTree;
import com.lgu.ccss.admin.system.menu.service.MenuServiceImpl;
import com.lgu.ccss.admin.system.program.domain.ProgramVO;
import com.lgu.ccss.admin.system.program.service.ProgramServiceImpl;
import com.lgu.ccss.common.utility.SessionUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping(value="/system/program")
public class ProgramController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProgramController.class);
	
    @Resource(name = "programService")
	private ProgramServiceImpl programService;
	
    @Resource(name = "menuService")
	private MenuServiceImpl menuService;
	
	
	@RequestMapping(value = "/listView.do")
	public String programListView(HttpServletRequest request) throws Exception {
		return "/system/programList";
	}
	
	/**
	 * 메뉴 리스트 조회(트리)
	 * @param request
	 * @param response
	 * @param menuTree
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/menuListAjax.do")
	public ModelAndView selectMenuList(HttpServletRequest request, HttpServletResponse response, @RequestBody MenuTree menuTree) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		
		List<Map<String, Object>> list =  menuService.selectMenuList();
		
		if(CollectionUtils.isNotEmpty(list)) {
			
			List<MenuTree> treeList = new ArrayList<MenuTree>();
			for( Map<String, Object> menuMap : list ) {
				treeList.add(new MenuTree(menuMap));
			}
			
			modelAndView.addObject("treeList", treeList);
		}

		return modelAndView;
	}
	
	/**
	 * 프로그램 리스트 조회(ajax)
	 * @param request
	 * @param response
	 * @param programVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/programListAjax.do")
	public ModelAndView selectProgramList(HttpServletRequest request, HttpServletResponse response, ProgramVO programVO) throws Exception {
	
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");


		modelAndView.addObject("programList", programService.selectProgramList(programVO));

		return modelAndView;
	}
	
	/**
	 * 프로그램 등록/수정
	 * @param request
	 * @param response
	 * @param programVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editProgramMenuAjax.do")
	public ModelAndView editProgramMenu(HttpServletRequest request, HttpServletResponse response,  ProgramVO programVO) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		
		programVO.setRegId(SessionUtil.getLoginId(request));
		programVO.setUpdId(SessionUtil.getLoginId(request));
		
		boolean result = true;
		try {
			if(StringUtils.isEmpty(programVO.getProgramId())) {
				//등록
				programService.insertProgram(programVO);
			} else {
				//수정
				programService.updateProgram(programVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = false;
		}
		
		if (result) {
			modelAndView.addObject("result", "success");
		} else {
			modelAndView.addObject("result", "fail");
		}
		
		return modelAndView;
	}
	
	@RequestMapping(value = "/deleteProgramMenuAjax.do")
	public ModelAndView deleteProgramMenu(HttpServletRequest request, HttpServletResponse response,  ProgramVO programVO) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		
		boolean result = true;
		
		try {
			programService.deleteProgramMenu(programVO);
		} catch (Exception e) {
			e.printStackTrace();
			result = false;
		}
		
		if (result) {
			modelAndView.addObject("result", "success");
		} else {
			modelAndView.addObject("result", "fail");
		}
		
		return modelAndView;
		
	}
	
	
}
