package com.lgu.ccss.admin.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javassist.expr.NewArray;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lgu.ccss.admin.admin.domain.AdminPagingVO;
import com.lgu.ccss.admin.admin.domain.AdminVO;
import com.lgu.ccss.admin.admin.service.AdminServiceImpl;
import com.lgu.ccss.admin.login.service.LoginServiceImpl;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.AES128Cipher;
import com.lgu.ccss.common.utility.PageUtil;
import com.lgu.ccss.common.utility.SessionUtil;

import devonframe.dataaccess.CommonDao;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {
	
	@Resource(name = "adminService")
	private AdminServiceImpl adminService;
	
	@Autowired
	private PageUtil pageUtil;
	
	@Resource(name = "commonDao_oracle")
	private CommonDao commonDao_oracle;
	/**
	 * 운영자관리 리스트 화면(DevOn Paging Sample Version)
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *//*
	@RequestMapping(value = "/adminList.do")
    public String adminListForm(HttpServletRequest request,AdminPagingVO adminPagingVO, ModelMap model) throws Exception {
		adminPagingVO.setRowSize(2);
		
		
		List<AdminVO> resultList = adminService.selectAdminPageList(adminPagingVO);
		
		 model.addAttribute("input", adminPagingVO);
		 model.addAttribute("resultList", resultList);
		 return "/admin/adminList";
	}*/
	
	
	/**
	 * 운영자관리 리스트 화면
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/adminListForm.do")
	public String adminListForm(HttpServletRequest request, ModelMap model) throws Exception {
		return "/admin/adminListForm";
	}
	
	
	
	/**
	 * 운영자관리 리스트 조회
	 * 
	 * @param request
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectAdminList.do", method = RequestMethod.POST)
	public Map<String, Object> selectAdminList(HttpServletRequest request, AdminVO adminVO) throws Exception {
		Map<String, Object> resultMap = adminService.selectAdminList(adminVO);
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(adminVO.getPage(), pageUtil.getTotalPage(totalCount, adminVO.getPageRowCount()), adminVO.getPageRowCount(), Constants.GO_SEARCH);
		
		resultMap.put(Constants.PAGING, paging);

		return resultMap;
	}
	
	/**
	 * 운영자 등록 화면
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/adminInsertForm.do")
	public String adminInsertForm(HttpServletRequest request, ModelMap model) throws Exception {
		model.addAttribute("roleInfo", adminService.selectAdminRoleList());
		return "/admin/adminInsertForm";
	}
	
	/**
	 * 운영자 등록 
	 * 
	 * @param request
	 * @param response
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertAdmin.do")
	public Map<String, Object> insertAdmin(HttpServletRequest request, HttpServletResponse response, AdminVO adminVO) throws Exception {
		adminVO.setUpdId(SessionUtil.getLoginId(request));
		adminVO.setRegId(SessionUtil.getLoginId(request));
		
		Map<String, Object> resultMap =  adminService.insertAdmin(adminVO);
		
		return resultMap;
	}
	
	/**
	 * 운영자 수정 화면
	 * 
	 * @param request
	 * @param model
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/adminUpdateForm.do" , method=RequestMethod.POST)
	public String adminUpdateForm(HttpServletRequest request, ModelMap model, AdminVO adminVO) throws Exception {
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		AdminVO tempVO = new AdminVO();
		tempVO.setMngrId(id);
		tempVO.setPassWd(pwd);
		AdminVO	 resultLogin = commonDao_oracle.select("Login.checkAdminPwd",tempVO);
		if(resultLogin != null) {
			model.put("adminVO", adminVO);
			
			
			model.addAttribute(Constants.RESULT, adminService.selectAdminDetail(adminVO));
			model.addAttribute("roleInfo", adminService.selectAdminRoleList());
			return "/admin/adminUpdateForm";
		} else{
			return "/admin/adminListForm";
		}
		
	}
	
	/**
	 * 운영자 수정
	 * 
	 * @param request
	 * @param response
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateAdmin.do" ,method = RequestMethod.POST)
	public Map<String, Object>  updateAdmin(HttpServletRequest request, HttpServletResponse response, AdminVO adminVO) throws Exception {
		String sessionMngrId = SessionUtil.getLoginId(request);
		
		//DEC
		
		String targetId = AES128Cipher.AES_Decode(adminVO.getMngrId(), "abcdefghijklmnop");
		adminVO.setUpdId(SessionUtil.getLoginId(request));
	
		adminVO.setMngrId(targetId);
		String decEmailAddr =  AES128Cipher.AES_Decode(adminVO.getEmailAddr(), "abcdefghijklmnop");
		adminVO.setEmailAddr(decEmailAddr);
		String decMngrNm =  AES128Cipher.AES_Decode(adminVO.getMngrNm(), "abcdefghijklmnop");
		adminVO.setMngrNm(decMngrNm);
		String decClphNo = AES128Cipher.AES_Decode(adminVO.getClphNo(), "abcdefghijklmnop");
		adminVO.setClphNo(decClphNo);
		
		String mngrLevel = commonDao_oracle.select("Admin.selectMngrLevel",sessionMngrId);
		AdminVO tempVO = new AdminVO();
		tempVO.setMngrId(sessionMngrId);
		tempVO.setMngrLevel(mngrLevel);
		tempVO = 		commonDao_oracle.select("Admin.checkAdminRoleId",tempVO);
		
		if(tempVO == null){
			if(!sessionMngrId.equals(targetId)){
				Map<String, Object> resultMap = new HashMap<String, Object>();
				resultMap.put(Constants.RESULT,Constants.NO);
				resultMap.put("sayMessage","비정상적인 요청입니다.");
				return resultMap;
			}
		}
		
		Map<String, Object> resultMap = adminService.updateAdmin(adminVO);
		return resultMap;
	}
	
	/**
	 * 사용자 임시 비밀 번호 발급
	 * 
	 * @param request
	 * @param response
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sendTmpPassWd.do")
	public Map<String, Object>  sendTmpPassWd(HttpServletRequest request, HttpServletResponse response, AdminVO adminVO) throws Exception {
		adminVO.setUpdId(SessionUtil.getLoginId(request));
		Map<String, Object> resultMap = adminService.sendTmpPassWd(adminVO);
		return resultMap;
	}
	
	
	
	/**
	 * 운영자 아이디 중복확인 
	 * 
	 * @param request
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/checkAdminId.do")
	public Map<String, Object> checkAdminId(HttpServletRequest request, AdminVO adminVO) throws Exception {
		Map<String, Object> resultMap = adminService.checkAdminId(adminVO);
		return resultMap;
	}
	/**
	 * 운영자 삭제
	 * @param request
	 * @param response
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteAdminAjax.do")
	public Map<String, Object> deleteAdmin(HttpServletRequest request, HttpServletResponse response, AdminVO adminVO) throws Exception {
		int cnt = adminService.deleteAdmin(adminVO);
		Map<String, Object> resultMap = new HashMap<>();
		
		if(cnt > 0){
			resultMap.put(Constants.RESULT, Constants.YES);
			adminService.deleteAdminMpng(adminVO);
		}else{
			resultMap.put(Constants.RESULT, Constants.YES);
		}
		
		return resultMap;
	}
	
	/**
	 * Admin 권한 체크
	 * @param request
	 * @param response
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/checkAdminRole.do")
	public Map<String, Object> checkAdminRole(HttpServletRequest request, HttpServletResponse response, AdminVO adminVO) throws Exception {
		Map<String, Object> resultMap = adminService.checkAdminRole(adminVO);
		return resultMap;
	}
	
	/**
	 * Admin 권한 체크(id)
	 * @param request
	 * @param response
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/checkAdminRoleId.do")
	public Map<String, Object> checkAdminRoleId(HttpServletRequest request, HttpServletResponse response, AdminVO adminVO) throws Exception {
		//String mngrLevel = adminVO.getMngrLevel();
		String sessionMngrId = SessionUtil.getLoginId(request);
		
		Map<String, Object> resultMap = adminService.checkAdminRoleId(sessionMngrId,adminVO);
		
		return resultMap;
	}
	
	
	/**
	 * 관리자 권한 위임
	 * @param request
	 * @param response
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/entrustRoleAdmin.do")
	public Map<String, Object> entrustRoleAdmin(HttpServletRequest request, HttpServletResponse response, AdminVO adminVO) throws Exception {
		adminVO.setUpdId(SessionUtil.getLoginId(request));
		Map<String, Object> resultMap = adminService.entrustRoleAdmin(adminVO);
		return resultMap;
	}
	
	
	/**
	 * Admin 사용자 정보 수정 패스워드 체크
	 * @param request
	 * @param response
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/checkAdminPwd.do")
	public Map<String, Object> checkAdminPwd(HttpServletRequest request, HttpServletResponse response, AdminVO adminVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String,Object>();
		String sessionId = SessionUtil.getLoginId(request);
		
		if(sessionId.equals(adminVO.getMngrId())){
			 resultMap = adminService.checkAdminPwd(adminVO);
		}else{
			 resultMap.put(Constants.RESULT, Constants.NO);
		}
		
		
		return resultMap;
	}
	
}
