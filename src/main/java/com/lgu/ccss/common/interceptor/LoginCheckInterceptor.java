package com.lgu.ccss.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.lgu.ccss.admin.admin.domain.AdminVO;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.SessionUtil;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {

    /** 로그인 URL	 */
	private final String LOGIN_URL = "/admin/login/loginView.do";
	
    /**
     * 세션에 (Auth)가 있는지 여부로 인증 여부를 체크한다. Auth 도메인 정보 없을시 , 로그인 페이지로 이동한다.
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	
    	
    	AdminVO loginInfo = (AdminVO)SessionUtil.get(request, Constants.SESSION_NAME);
    	
    	if(loginInfo != null){
    		
    	} else {
    		response.sendRedirect(LOGIN_URL);
			return false;
    	}
    	
    	return true;
    }
}
