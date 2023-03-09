package com.lgu.ccss.admin.system.role.controller;

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
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.lgu.ccss.admin.system.role.domain.RoleMenuVO;
import com.lgu.ccss.admin.system.role.domain.RoleTree;
import com.lgu.ccss.admin.system.role.domain.RoleVO;
import com.lgu.ccss.admin.system.role.service.RoleServiceImpl;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.PageUtil;
import com.lgu.ccss.common.utility.SessionUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping(value = "/system/role")
public class RoleController {
	
	private static final Logger logger = LoggerFactory.getLogger(RoleController.class);
			
	@Resource(name = "roleService")
	private RoleServiceImpl roleService;
	
	@Autowired
	private PageUtil pageUtil;
	
	/**
	 * 권한 그룹 관리 리스트 페이지 이동 & 리스트 조회
	 * @param request
	 * @param roleVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/listView.do")
	public ModelAndView roleList(HttpServletRequest request, @ModelAttribute("role") RoleVO roleVO) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView("/system/roleList");
		
		
		Map<String, Object> resultMap = roleService.roleList(roleVO);
		
		String paging = pageUtil.getPagingString(roleVO.getPage(), pageUtil.getTotalPage(Integer.parseInt(resultMap.get("totalCount").toString()), roleVO.getPageRowCount()) , roleVO.getPageRowCount(), Constants.GO_PAGE);
		resultMap.put("paging", paging);
		modelAndView.addObject("resultData", resultMap);
		return modelAndView;
	}
	
	/**
	 * 메뉴 권한 보기 페이지 이동
	 * @param request
	 * @param roleVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/roleMenuListView.do")
	public String roleMenuListView(HttpServletRequest request, @ModelAttribute("role") RoleVO roleVO, ModelMap model) throws Exception {
		model.addAttribute("role", roleService.selectRole(roleVO));
		return "/system/roleMenuList";
	}
	
	/**
	 * 메뉴 권한 보기 리스트 조회
	 * @param request
	 * @param response
	 * @param roleMenuVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/roleMenuListAjax.do")
	public ModelAndView selectRoleMenuList(HttpServletRequest request, HttpServletResponse response, @RequestBody RoleMenuVO roleMenuVO, ModelMap model) throws Exception {
	
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		
		List<Map<String, Object>> roleMenuList = roleService.selectRoleMenuListAll(roleMenuVO);
		
		if(CollectionUtils.isNotEmpty(roleMenuList)) {
			List<RoleTree> treeList = new ArrayList<RoleTree>();
			for(Map<String, Object> roleMap : roleMenuList) {
				treeList.add(new RoleTree(roleMap));
			}
			modelAndView.addObject("treeList", treeList);
		}
		
		return modelAndView;
	}
	
	/**
	 * 메뉴 권한 등록/수정
	 * @param request
	 * @param response
	 * @param roleTree
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editRoleMenuAjax.do")
	public ModelAndView editRoleMenu(HttpServletRequest request, HttpServletResponse response,  RoleTree roleTree) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		
		
		try {
			roleService.editRoleMenu(roleTree);
		} catch (Exception e) {
			logger.error("editRoleMenu Exception",e);
		}
		
		return modelAndView;
	}
	
	/**
	 * 프로그램 권한 관리 페이지 이동
	 * @param request
	 * @param response
	 * @param roleVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/roleProgramListView.do")
	public String roleProgramListView(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("role") RoleVO roleVO, ModelMap model) throws Exception {
		
		model.addAttribute("role", roleService.selectRole(roleVO));
		return "/system/roleProgramList";
	}
	
	/**
	 * 프로그램 권한 관리 리스트 조회
	 * @param request
	 * @param response
	 * @param roleMenuVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/roleMenuListOneRoleAjax.do")
	public ModelAndView roleMenuListOneRole(HttpServletRequest request, HttpServletResponse response, @RequestBody RoleMenuVO roleMenuVO) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		
		
		List<Map<String, Object>> roleMenuList = roleService.selectRoleMenuListOneRole(roleMenuVO);
		
		if(CollectionUtils.isNotEmpty(roleMenuList)) {
			List<RoleTree> treeList = new ArrayList<RoleTree>();
			for(Map<String, Object> roleMap : roleMenuList) {
				treeList.add(new RoleTree(roleMap));
			}
			modelAndView.addObject("treeList", treeList);
		}
		
		return modelAndView;
	}
	
	/**
	 * 메뉴별 프로그램 리스트 조회
	 * @param request
	 * @param response
	 * @param roleMenuVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/roleProgramListAjax.do")
	public ModelAndView roleProgramList(HttpServletRequest request, HttpServletResponse response, @RequestBody RoleMenuVO roleMenuVO) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		
		modelAndView.addObject("roleProgramList", roleService.selectRoleProgramList(roleMenuVO));
	
		return modelAndView;
	}
	
	/**
	 * 메뉴별 포로그램 권한 등록/수정
	 * @param request
	 * @param response
	 * @param roleTree
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/roleProgramRegistAjax.do")
	public ModelAndView roleProgramRegist(HttpServletRequest request, HttpServletResponse response,  RoleTree roleTree) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		
		RoleVO roleVO = new RoleVO(roleTree.getMngrGrpId(), roleTree.getMenuId());
		
		List<RoleVO> roleProgramList = new ArrayList<RoleVO>();
		
		try {
			
			if(roleTree.getProgramIds().size() > 0) {
				
				for(String programId : roleTree.getProgramIds()) {
					roleProgramList.add(new RoleVO(roleVO.getRoleId(), roleVO.getMenuId(), programId));
				}
				
				roleService.insertRoleProgram(roleVO, roleProgramList);
			
			}else{
				
				roleService.insertRoleProgram(roleVO, null);
			}
			
		}catch (Exception  e){
			logger.error("roleProgramRegist Exception :",e);
		}
		
		return modelAndView;
	}

	
	/**
	 * 권한 그룹 등록/수정
	 * @param request
	 * @param response
	 * @param roleVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/roleRegistView.do")
	public String roleRegistView(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("role") RoleVO roleVO, Model model) throws Exception {
		
		model.addAttribute("roleId", roleVO.getRoleId());
		model.addAttribute("Role", roleService.selectRole(roleVO));
		
		return "/system/roleEdit";
		
	}

	@RequestMapping(value = "/editRoleAjax.do")
	public String editRole(HttpServletRequest request, @ModelAttribute("role") RoleVO roleVO, Model model) throws Exception {
		
		roleVO.setRegId(SessionUtil.getLoginId(request));
		roleVO.setUpdId(SessionUtil.getLoginId(request));
		
		if(StringUtils.isEmpty(roleVO.getRoleId())) {
			roleVO.setRoleId(roleService.insertRole(roleVO));
			model.addAttribute("resultMsg", "success");
		} else {
			roleService.updateRole(roleVO);
			model.addAttribute("resultMsg", "success");
			
		}
		
		return "redirect:/system/role/listView.do";
	}
	
	@RequestMapping(value = "/deleteRoleAjax.do")
	public String deleteRole(HttpServletRequest request, @ModelAttribute("role") RoleVO roleVO, Model model) throws Exception {
		
		roleService.deleteRole(roleVO);
		model.addAttribute("resultMsg", "success");

		return "redirect:/system/role/listView.do";
		
	}
}
