package com.lgu.ccss.admin.system.menu.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.lgu.ccss.admin.system.menu.domain.MenuTree;
import com.lgu.ccss.admin.system.menu.service.MenuServiceImpl;
import com.lgu.ccss.common.utility.SessionUtil;

@Controller
@RequestMapping(value = "/system/menu")
public class MenuController {

	private static final Logger logger = LoggerFactory.getLogger(MenuController.class);
	
    @Resource(name = "menuService")
	private MenuServiceImpl menuService;
	
	
	@RequestMapping(value="/setting")
	public void menuSetting(HttpServletRequest request) throws Exception {
		menuService.menuMapSetting();
	}
	
	
	
	
	/**
	 * 메뉴리스트 뷰 페이지 이동
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/listView.do")
	public String menuList(HttpServletRequest request) throws Exception {
		return "/system/menuList";
		
	}
	
	/**
	 * 메뉴리스트 조회 (ajax)
	 * @param request
	 * @param response
	 * @param vo
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/listAjax.do")
	public ModelAndView selectMenuList(HttpServletRequest request, HttpServletResponse response,  @RequestBody MenuTree vo, ModelMap model) throws Exception {
		
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
	 * 메뉴 등록/수정
	 * @param request
	 * @param response
	 * @param vo
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editMenuAjax.do")
	public ModelAndView edit(HttpServletRequest request, HttpServletResponse response,  MenuTree vo, ModelMap model) throws Exception {
		
		logger.debug("####### MenuTree:" + vo);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		
		vo.setRegId(SessionUtil.getLoginId(request));
		vo.setUpdId(SessionUtil.getLoginId(request));
		// MenuId로 Insert, Update 구분	
		if(StringUtils.isEmpty(vo.getMenuId())) {
			menuService.menuInsert(vo);
		} else {
			menuService.menuUpdate(vo);
		}
		return modelAndView;
	}
	
	/**
	 * 메뉴 순서 변경
	 * @param request
	 * @param response
	 * @param menuTree
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateMenuOrderAjax.do")
	public ModelAndView updateMenuOrder(HttpServletRequest request, HttpServletResponse response, MenuTree menuTree) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		
		menuTree.setUpdId(SessionUtil.getLoginId(request));
		
		boolean result = true;
		try {
			menuService.updateMenuOrder(menuTree);
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
	
	@RequestMapping(value = "/deleteMenuAjax.do")
	public ModelAndView deleteMenu(HttpServletRequest request, HttpServletResponse response, MenuTree menuTree) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		
		boolean result = true;
		try {
			menuService.deleteMenu(menuTree);
		} catch (Exception e) {
			e.printStackTrace();
			result = false;
		}
		
		if(result) {
			
		} else {
			
		}
		
		return modelAndView;
	}
}
