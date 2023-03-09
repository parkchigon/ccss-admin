package com.lgu.ccss.common.interceptor;

import java.util.Enumeration;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceAware;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.PathMatcher;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.UrlPathHelper;

import com.lgu.ccss.common.utility.StringUtil;

/**
 * 컨트롤러의 전반적인 전후 처리를 위한 인터셉터 클래스. <br/>
 * 시스템 점검, 요청 정보 등을 다룬다.
 * 
 */
public class RequestInterceptor extends HandlerInterceptorAdapter implements MessageSourceAware {

    private static final Logger logger = LoggerFactory.getLogger(RequestInterceptor.class);

    private MessageSource messageSource = null;

    private UrlPathHelper urlPathHelper = new UrlPathHelper();

    private PathMatcher pathMatcher = new AntPathMatcher();

    /** excludes */
    private Set<String> excludes = new HashSet<String>();
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        if (logger.isInfoEnabled()) {
            StringBuilder builder = new StringBuilder();
            builder.append("\n=============== Request URI ================\n")
            		.append(' ').append(request.getRequestURI()).append('\n')
            		.append(" Client IP      : ").append(request.getRemoteAddr()).append(':').append(request.getRemotePort()).append('\n')
            		.append(" Method         : ").append(request.getMethod()).append('\n');
            
            if(!excluedesUrlCheck(request)){
	            builder.append("=========== Request Parameters =============\n");
	            for (Enumeration<String> enumer = request.getParameterNames(); enumer.hasMoreElements();) {
	                String name = enumer.nextElement();
	
	                if (!StringUtil.chkNum(name)) {
	
	                    if (request.getParameterValues(name).length > 1) {
	                        builder.append(' ').append(StringUtils.rightPad(name + "[]", 14)).append(" : ");
	
	                        for (int i = 0; i < request.getParameterValues(name).length; i++) {
	                            builder.append((request.getParameterValues(name))[i]);
	                            if (i == request.getParameterValues(name).length - 1) {
	                                builder.append('\n');
	                            } else {
	                                builder.append(", ");
	                            }
	                        }
	                    } else {
	                        builder.append(' ').append(StringUtils.rightPad(name, 14)).append(" : ").append(request.getParameter(name)).append('\n');
	                    }
	                }
	
	            }
            }
            builder.append("============================================");
            logger.info(builder.toString());
        }

        request.setAttribute("transactionTime", System.currentTimeMillis());
        return super.preHandle(request, response, handler);
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView mav) throws Exception {
        response.setHeader("Cache-control", "no-cache, no-store, must-revalidate, post-check=0, pre-check=0");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "-1");
        
        
        //*************************************************************************
        // [charves] 보안 취약점 지적사항에 대한 보완 조치
        //*************************************************************************
        // [ Content-Security-Policy ] : 브라우저에 XSS와 같은 공격을 막아주는 헤더 보안 정책 설정
        //      구분 항목 : default-src, script-src, style-src, img-src
        //				default-src   : 기본 허용여부 설정
        //				script-src    : 스크립트 허용여부 설정
        //				style-src     : 스타일 허용여부 설정
        //				img-src		  : 이미지 파일 허용여부 설정
        //      설정 옵션 : none, self, [도메인URL]
        //				none          : 어떤것도 허용하지 않음
        //				self          : 현재의 출처에서만 허용(하위 도메인에서는 허용되지 않음)
        //				[도메인URL]	  : 특정 도메인만 허용
        //		예외 허용 : unsafe-inline, unsafe-eval
        //              unsafe-inline  : <script></script>, <style></style> 태그 허용
        //              unsafe-eval    : eval()같은 text기반의 javascript 메커니즘 허용
        //      사용 예제 : response.setHeader("Content-Security-Policy", "default-src 'self' 'unsafe-inline' 'unsafe-eval'");  : 기본소스 자기자신, script허용, eval사용 허용
        //              response.setHeader("Content-Security-Policy", "script-src [도메인URL]");   : 해당 도메인만 script를 허용한다.   
        //              response.setHeader("Content-Security-Policy", "style-src [도메인URL]");    : 해당 도메인만 style을 허용한다.   
        //              response.setHeader("Content-Security-Policy", "img-src [도메인URL]");      : 해당 도메인만 image를 허용한다.
        //              response.setHeader("Content-Security-Policy", "default-src 'none'");     : 현재요소는 어떤출처에서든 허용하지 않음
        //              response.setHeader("Content-Security-Policy", "default-src 'self'");     : 현재요소는 해당 출처에서만 허용됨
        //              response.setHeader("Content-Security-Policy", "child-src 'none'");       : iframe등의 하위요소는 절대 허용하지 않음
        //              response.setHeader("Content-Security-Policy", "child-src 'self'");       : iframe등의 하위요소는 해당 출처에서만 허용됨
        // [ X-Frame-Option ] : ClickJacking 방지 (ClickJacking : 버튼등을 클릭할때 다른곳이 클릭되도록 유도하는 방식 )
        //		설정 옵션 : DENY, SAMEORIGIN, ALLOW FROM [도메인URL]
        //				DENY 					: iframe과 같은 사용을 모두 금한다.
        //				SAMEORIGIN 				: iframe같은 경우 동일한 출처라면 허락한다.
        //				ALLOW FROM [도메인URL] 	: iframe같은 경우 해당 도메인만 허용한다.
        //		사용 예제 : response.setHeader("X-Frame-Options", "SAMEORIGIN");
        // [ X-Content-Type-Option ] : MIMETYPE이 일치하지 않는 경우에 차단, script테그등의 src변조를 막아준다.
        //		설정 옵션 : nosniff : 
        //		사용 예제 : response.setHeader("X-Content-Type-Options", "nosniff");
        // [ X-XSS-Protection] : XSS 공격 차단
        //		사용 예제 : response.setHeader("X-XSS-Protection", "1;mode=block");
        //*************************************************************************
        response.setHeader("Content-Security-Policy", "default-src 'self' 'unsafe-inline' 'unsafe-eval'");
        //response.setHeader("X-Frame-Options", "SAMEORIGIN");	// 보안 취약점 점검 툴(Potify) 체크결과에서 해당 사항이 없으므로 이부분은 일단 해제한다.
        response.setHeader("X-Content-Type-Options", "nosniff");
        response.setHeader("X-XSS-Protection", "1;mode=block");
        //*************************************************************************
        // response.setContentType("text/html;charset=utf-8"); ※a

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        if (!isExcluded(request)) {
            if (logger.isInfoEnabled()) {
                logger.info("*********turnaround time : " + (System.currentTimeMillis() - (Long) request.getAttribute("transactionTime")));
            }
        }
    }

    public void setMessageSource(MessageSource messageSource) {
        this.messageSource = messageSource;
    }

    /**
     * 무시된 요청인지 검증한다.
     * 
     * @param request
     *            {@link HttpServletRequest}
     * @return true or false
     */
    public boolean isExcluded(HttpServletRequest request) {
        final String path = urlPathHelper.getLookupPathForRequest(request);

        if (!excludes.isEmpty()) {
            if (excludes.contains(path)) {
                logger.debug(path + "is excluded!!");
                return true;
            }
            for (String urlMapping : excludes) {
                if (pathMatcher.match(urlMapping, path)) {
                    logger.debug(path + "is excluded!!");
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * 로깅에서 제외할 URL
     */
    public void setExcludes(Set<String> excludes) {
        this.excludes = excludes;
    }
    
    public boolean excluedesUrlCheck (HttpServletRequest request){
    	boolean flag= false;
    	
    	if(request.getRequestURI().indexOf("common/error") > -1){
    		flag = true;
    	}
    	return flag;
    }
}
