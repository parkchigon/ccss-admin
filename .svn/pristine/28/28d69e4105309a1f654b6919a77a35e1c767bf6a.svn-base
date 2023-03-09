package com.lgu.ccss.admin.login.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.lgu.ccss.admin.admin.domain.AdminVO;
import com.lgu.ccss.admin.login.service.LoginServiceImpl;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.service.ServiceConfig;
import com.lgu.ccss.common.utility.SessionUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping(value = "/login")
public class LoginController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
    
	@Resource(name = "loginService")
	private LoginServiceImpl loginService;
    
    /**
     * 로그인 화면
     * @param request
     * @param params
     * @param model
     * @return
     */
    @RequestMapping(value = "/loginView.do")
    public String loginView(HttpServletRequest request, @RequestParam Map<String, String> params, ModelMap model) {

        return "/login/loginView";
    }
    
    /**
     * ID 찾기 화면
     * @param request
     * @param params
     * @param model
     * @return
     */
    @RequestMapping(value = "/findIdView.do")
    public String findIdView(HttpServletRequest request, @RequestParam Map<String, String> params, ModelMap model) {

        return "/login/findIdView";
    }
    
    /**
     * PWD 찾기 화면
     * @param request
     * @param params
     * @param model
     * @return
     */
    @RequestMapping(value = "/findPwdView.do")
    public String findPwdView(HttpServletRequest request, @RequestParam Map<String, String> params, ModelMap model) {

        return "/login/findPwdView";
    }
    
    
    /**
     * ID 찾기 처리
     * @param request
     * @param response
     * @param adminVO
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/excuteFindId.do")
    public  Map<String, Object> excuteFindId(HttpServletRequest request, HttpServletResponse response, AdminVO adminVO) throws Exception {
		
		AdminVO adminInfo = loginService.checkFindId(adminVO);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		if (adminInfo != null) {
			if(adminInfo.getResultType().equals(Constants.YES)){
				returnMap.put(Constants.RESULT, Constants.YES);
				returnMap.put("mngrId", adminInfo.getMngrId());
			}else{
				returnMap.put(Constants.RESULT, Constants.NO);
			}
		} else {
			returnMap.put(Constants.RESULT, Constants.NOT_USER);
		}	
		return returnMap;
	}
    
    /**
     * PWD 찾기 처리
     * @param request
     * @param response
     * @param adminVO
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/excuteFindPwd.do")
    public  Map<String, Object> excuteFindPwd(HttpServletRequest request, HttpServletResponse response, AdminVO adminVO) throws Exception {
    	Map<String, Object> returnMap = new HashMap<String, Object>();
		
    	AdminVO adminInfo = loginService.checkFindPwd(adminVO);
		
		if (adminInfo != null) {
			if(adminInfo.getResultType().equals(Constants.YES)){  // 메일 발송 성공
				returnMap.put(Constants.RESULT, Constants.YES);
				
			}else if(adminInfo.getResultType().equals(Constants.RETRY)){ // 재시도 
				
				returnMap.put(Constants.RESULT, Constants.RETRY);
				
			}else if(adminInfo.getResultType().equals(Constants.ACCOUNT_LOCK)){
				
				returnMap.put(Constants.RESULT, Constants.FAIL_ACCOUNT_LOCK);
				
			}else if(adminInfo.getResultType().equals(Constants.ACCOUNT_DISABLED)){
				
				returnMap.put(Constants.RESULT, Constants.FAIL_ACCOUNT_DISABLED);
			
			}else{
				
				returnMap.put(Constants.RESULT, Constants.NO); // 정보 불일치
			}
			
		} else {
			
			returnMap.put(Constants.RESULT, Constants.NOT_USER); // 정보 없음.
		}	
		return returnMap;
	}
    
    /**
     * PWD 변경 처리
     * @param request
     * @param response
     * @param adminVO
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateAdminPwd.do")
    public  Map<String, Object> updateAdminPwd(HttpServletRequest request, HttpServletResponse response, AdminVO adminVO) throws Exception {
    	Map<String, Object> returnMap = new HashMap<String, Object>();
		
    	String sessionMngrId = SessionUtil.getLoginId(request);
    	
    	/*if( !sessionMngrId.equals(adminVO)){
    		returnMap.put(Constants.RESULT, Constants.BAD);
    		return returnMap;
    	}*/
    	
    	AdminVO adminInfo = loginService.updateAdminPwd(adminVO);
		
		if (adminInfo != null) {
			if(adminInfo.getResultType().equals(Constants.YES)){  //성공
				returnMap.put("redirectUrl", "/admin/login/loginView.do");
				returnMap.put(Constants.RESULT, Constants.YES);
			}else if(adminInfo.getResultType().equals(Constants.FAIL)){ // 업데이트 실패
				returnMap.put(Constants.RESULT, Constants.FAIL);
			}else{
				returnMap.put(Constants.RESULT, Constants.NO); // 정보 불일치
			}
		} else {
			returnMap.put(Constants.RESULT, Constants.NOT_USER); // 정보 없음.
		}	
		return returnMap;
	}
    
    /**
     * 로그인 처리
     * @param request
     * @param response
     * @param adminVO
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/excuteLogin.do", method = RequestMethod.POST)
    public  Map<String, Object> excuteLogin(HttpServletRequest request, HttpServletResponse response, AdminVO adminVO) throws Exception {
		
    	HttpSession session = request.getSession();
		String sessionId = session.getId();
		String ipAddress = request.getRemoteAddr();
		logger.info("###########################################");
		logger.info("Client IP : "  + ipAddress);
		logger.info("SESSION ID : " + sessionId);
		logger.info("###########################################");
		
		//*********************************************************************
		// 보안 취약점 검사 결과 : 내부 IP 노출 패턴 발견 
		// 본 소스를 주석처리 할 경우 내부 [서버 내부 오류가 발생한다]
		// 따라서 우선 실제 ipAddress를 넣지 않고 " "을 넣도록 하고, 만일 보안검사툴이 그래도 지적할 경우엔 IP관련 칼럼을 Nullable True로 하여 필수값이아니도록 하여야 할 것이다.
		//*********************************************************************
		adminVO.setLoginIp(" ");	// 
		//*********************************************************************
		
		adminVO.setSessionId(sessionId);
		

		String adminPwEnc = adminVO.getPassWd();
		AdminVO loginInfo = loginService.checkAdminPwd(adminVO);
		
		//System.out.println("###########################");
		//System.out.println("loginInfo.getResultType():" + loginInfo.getResultType());
		//System.out.println("###########################");
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		if (loginInfo != null ) {
			
			if (SessionUtil.get(request, Constants.SESSION_NAME) != null) {
				SessionUtil.invalidate(request);
			}
			loginInfo.setPassWdEnc(adminPwEnc);
			
			loginInfo.setPassWd("");
			//loginInfo.setMngrNm("");
			loginInfo.setClphNo("");
			loginInfo.setPassWdEnc("");
			loginInfo.setUseYn("");
			loginInfo.setLoginFailCount(0);
			loginInfo.setPwChgDt("");
			loginInfo.setRegDt("");
			loginInfo.setAccountStatus("");
			loginInfo.setPwModDispYn("");
			loginInfo.setIpAddr("");
			
			SessionUtil.put(request, ServiceConfig.SESSION_KEY_USER_ID, loginInfo.getMngrId());
			SessionUtil.put(request, ServiceConfig.SESSION_KEY_USER_NAME, loginInfo.getMngrNm());
			SessionUtil.put(request, Constants.SESSION_NAME, loginInfo);
			
			SessionUtil.put(request, "LOGIN_TYPE", "MANAGER");
			SessionUtil.put(request, "MNGR_GRP_ID", loginInfo.getMngrLevel());
			
		
			
			returnMap.put(Constants.RESULT, Constants.YES);
			
			if(loginInfo.getResultType() == null) {
				try{
					/* sms 2차 인증에서 수행하던 로직 1차 id/pw에서 수행 */
					String roleId = (String) request.getSession().getAttribute("MNGR_GRP_ID");
					
					//logger.debug("1################# roleId:" + roleId);
					
					HashMap menuMap = (HashMap) ServiceConfig.MENU_MAP.get(roleId);
					//logger.debug("2################# menuMap:" + menuMap);
					
					HashMap siteMap = (HashMap) menuMap.get("/");
					//logger.debug("3################# siteMap:" + siteMap);
					
					List _programList = (List)siteMap.get( "MENU_LIST_MAP" ); // 프로그램리스트
					//logger.debug("4################# _programList:" + _programList);
					Object[] _objProgramList = _programList.toArray();
					//for(int i=0; i <_objProgramList.length; i++){
					//	logger.debug("5-"+i+"################# _objProgramList:" + _objProgramList[i]);
					//}
					siteMap = (HashMap) siteMap.get("MENU_MAP");
					//logger.debug("6################# siteMap:" + siteMap);
					
					ArrayList _menuList = (ArrayList)siteMap.get("subNodeList"); // 메뉴리스트
					//logger.debug("7################# _menuList:" + _menuList);
					
					HashMap _menuMap = (HashMap)_menuList.get(0);
					//logger.debug("8################# _menuMap:" + _menuMap);
					
					String redirectUrl = getMenuUrl( _menuMap, _objProgramList );
					//logger.debug("9################# redirectUrl:" + redirectUrl);
					returnMap.put("redirectUrl", redirectUrl);
					
					loginInfo.setPassWd("");
					//loginInfo.setMngrNm("");
					loginInfo.setClphNo("");
					loginInfo.setPassWdEnc("");
					
					// 성공
					AdminVO succVO = new AdminVO();
					
					returnMap.put("login_info", succVO);
				}catch (Exception e){
					logger.error("Exception :",e);
				}
			}else{
				// 성공이나 비정상 상태 (아이디 비활성화 등)
				AdminVO failVO = new AdminVO();
				failVO.setResultType(loginInfo.getResultType());
				failVO.setLoginFailCount(loginInfo.getLoginFailCount());
				returnMap.put("login_info", failVO);
				
				AdminVO dummyLoginInfo = new AdminVO();
				SessionUtil.put(request, Constants.SESSION_NAME, dummyLoginInfo);
				
			}
			//if (loginInfo.getResultType()().equals(anObject))
		
			//returnMap.put("login_info", loginInfo);
				
				
		} else {
			AdminVO dummyLoginInfo = new AdminVO();
			SessionUtil.put(request, Constants.SESSION_NAME, dummyLoginInfo);
			returnMap.put(Constants.RESULT, Constants.NOT_USER);
		}
		
		logger.debug("returnMap",returnMap);
		
		logger.debug("##### Return Session Info : "+ SessionUtil.get(request, Constants.SESSION_NAME) + " #####");
		
		return returnMap;
	}
    
    /** 
     * 로그아웃 처리
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/excuteLogout.do")
	public String excuteLogout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/login/loginView.do";
	}
	
	
	/**
	 * 로그인 인증번호 체크
	 * 
	 * @param request
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/checkAuthNo.do")
	public Map<String, Object> checkAuthNo(HttpServletRequest request, AdminVO adminVO) throws Exception {
		Map<String, Object> returnMap = loginService.checkAuthNo(adminVO);
		
		if(returnMap.get(Constants.RESULT).toString().equals(Constants.YES)) {
			
		
			String roleId = (String) request.getSession().getAttribute("ROLE_ID");
			HashMap menuMap = (HashMap) ServiceConfig.MENU_MAP.get(roleId);
			HashMap siteMap = (HashMap) menuMap.get("/");
			List _programList = (List)siteMap.get( "MENU_LIST_MAP" ); // 프로그램리스트
			Object[] _objProgramList = _programList.toArray();
			
			siteMap = (HashMap) siteMap.get("MENU_MAP");
			ArrayList _menuList = (ArrayList)siteMap.get("subNodeList"); // 메뉴리스트
			HashMap _menuMap = (HashMap)_menuList.get(0);
			String redirectUrl = getMenuUrl( _menuMap, _objProgramList );
			
			returnMap.put("redirectUrl", redirectUrl);
		}
		return returnMap;
    }
	
	
	public String getMenuUrl(HashMap menuMap, Object[] programList) {

		String programUrl = "";
		ArrayList subMenuList = (ArrayList) menuMap.get("subNodeList");
		HashMap subMenuMap = new HashMap();
		if (subMenuList.size() > 0) {
			subMenuMap = (HashMap) subMenuList.get(0);
			String menuId = String.valueOf(subMenuMap.get("menuId"));
			for (int i = 0; i < programList.length; i++) {
				Map programMap = (Map) programList[i];
				String programMenuId = String.valueOf(programMap.get("menuId"));
				if (menuId.equals(programMenuId) && "Y".equals(String.valueOf(programMap.get("stProgramYn")))) {
					programUrl = String.valueOf(programMap.get("programUrl"));
					break;
				}
			}
		} else {
			programUrl = String.valueOf(menuMap.get("programUrl"));
		}

		if (programUrl == null || "".equals(programUrl))
			programUrl = getMenuUrl(subMenuMap, programList);

		return programUrl;
	}
}
