package com.lgu.ccss.common.aop;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.lgu.ccss.admin.admin.domain.AdminVO;
import com.lgu.ccss.admin.system.menu.service.MenuServiceImpl;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.exception.MenuAuthorizedException;
import com.lgu.ccss.common.service.ServiceConfig;


public class DefaultSession {
	private static final Logger logger = LoggerFactory.getLogger(DefaultSession.class);
	
	@Autowired
	private MenuServiceImpl menuService;
	/**
	 * 권한별 이용가능한 메뉴정보를 조회하여 메뉴데이타를 생성한다.
	 * 
	 * @param jp
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public void defaultSession(JoinPoint jp) throws Exception {
	//public void defaultSession(ProceedingJoinPoint jp) throws Exception {
		long startTime = System.currentTimeMillis();
		//System.out.println("############startTime : "+ startTime);
		Object[] obj = jp.getArgs();
		
		//menuService.menuMapSetting();

		if (obj.length > 0) {

			for (int i = 0; i < obj.length; i++) {

				if (obj[i] instanceof HttpServletRequest) {

					HttpServletRequest req = (HttpServletRequest) obj[i];
					HttpSession session = req.getSession();

                    // 요청한 URL을 구한다
                    String currUrl = "";
                    if (80 == req.getServerPort()) {
                        currUrl = req.getServerName() + req.getRequestURI();
                    } else {
                        currUrl = req.getServerName() + ":" + req.getServerPort() + req.getRequestURI();
                    }
                    
                    //요청 IP
                    String loginIp = req.getRemoteAddr();
                    
                    
					String roleId = (String) session.getAttribute("MNGR_GRP_ID");
					if (roleId == null) {
						// 세션에 롤아이디가 없는 경우 게스트롤 아이디를 셋팅
						session.setAttribute("MNGR_GRP_ID", roleId);
					}					
					
					// 메뉴데이타가 없는 경우만 진행
					
					if (ServiceConfig.MENU_MAP == null) {
						menuService.menuMapSetting();
						
					}else{
					
						Set key = ServiceConfig.MENU_MAP.keySet();
						HashMap menuMap = new HashMap();
						String loginUrl = "";
						List programList = null;
						//System.out.println("4##################################################");
						for (Iterator iterator = key.iterator(); iterator.hasNext();) {
							String roleTp = (String) iterator.next();
							if (roleTp.equals(roleId)) {
								//System.out.println("5##################################################");	
						
								HashMap hm = (HashMap) ServiceConfig.MENU_MAP.get(roleTp);
								Set siteKey = hm.keySet();
								//System.out.println("6##################################################");	
								for (Iterator siteIterator = siteKey.iterator(); siteIterator.hasNext();) {

	                                String urlTp = (String) siteIterator.next();
	                                if (currUrl.indexOf(urlTp) > -1) {
	                                	//System.out.println("7##################################################");
	                                    HashMap siteMap = (HashMap) hm.get(urlTp);
	                                    menuMap = (HashMap) siteMap.get("MENU_MAP");
	                                    loginUrl = (String) siteMap.get("LOGIN_URL");
	                                    programList = (List) siteMap.get("MENU_LIST_MAP");
	                                    
	                                    AdminVO adminVO = (AdminVO) session.getAttribute(Constants.SESSION_NAME);
	                                    ///System.out.println("8##################################################");
	                                    
		                                 // 요청에 대해서 접속 로그를 기록한다.
		                                 Object[] objList = programList.toArray();
		                                 boolean roleCheckFlag = false;
		                                 
		                                 for (int j = 0; j < objList.length; j++) {
		                                 	Map map = (Map) objList[j];
		                                 	
		                                 	if (currUrl.substring(currUrl.indexOf("/")).equals(map.get("programUrl"))) {
		                                 		 if(adminVO !=null){
		 	                                    	adminVO.setReqUrl(currUrl.substring(currUrl.indexOf("/")));
		 	                                    	adminVO.setLoginIp(loginIp);
		 	                                    	
		 	                                    	long endTime = System.currentTimeMillis();
		 	                                    	//System.out.println("############endTime : "+ endTime);
		 	                                    	long processDt = endTime - startTime;
		 	                                    	
		 	                                    	try{
		 	                                    		menuService.insertMngrUseHstr(adminVO,processDt);
		 	                                    	}catch(Exception e){
		 	                                    		e.printStackTrace();
		 	                                    	}
		 	                                    	
		 	                                    	roleCheckFlag = true;
		 	                                    }
		                                 		break;
		                                 	}
		                                 }
		                                 String targetUrl = currUrl.substring(currUrl.indexOf("/"));
		                                 if(!roleCheckFlag  &&  
		                                		 (  
		                                			!(targetUrl.indexOf("login") > -1)
		                                			&& !(targetUrl.indexOf("selectDtlCodeList") > -1) 
		                                		    
		                                		)){
		                                	 //System.out.println("9 targetUrl :" + targetUrl);
		                                	 //System.out.println("9##################################################");
		                                	 throw new MenuAuthorizedException("ID:" + String.valueOf(adminVO.getMngrId()) + " NO_AUTH URL:" + targetUrl);
		                                	 
		                                	
		                                 }
		                                 
										break;	                                	
	                                }
								}
								break;
							}
							//System.out.println("10##################################################");	
						}

						// 요청한 url에 대한 권한이 있는지 검사
						req.setAttribute("MENU_MAP", menuMap);
						req.setAttribute("LOGIN_URL", loginUrl);
						req.setAttribute("MENU_LIST_MAP", programList);

						break;						
						
					}
	
				}
			}
		}
	}
}
