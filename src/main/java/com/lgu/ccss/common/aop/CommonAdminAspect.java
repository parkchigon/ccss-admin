package com.lgu.ccss.common.aop;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lgu.ccss.common.enums.NameEnum;

@Aspect
public class CommonAdminAspect {

    private static final Logger logger = LoggerFactory.getLogger(CommonAdminAspect.class);

    /**
     * API 전처리
     * 
     * @param joinPoint
     * @throws Exception
     */
    public void commonBefore(JoinPoint joinPoint) throws Exception {
    	logger.info("##### " + joinPoint.getSignature() + " START #####");
    }

    /**
     * Method 정상 실행 시
     * @param joinPoint
     * @throws Exception
     */
    @AfterReturning(pointcut ="execution(* com.lgu.ccss..*Controller.*(..))", returning = "returnVal")
    public void commonAfterReturn(JoinPoint joinPoint, Map<String, Object> returnVal) throws Exception {
    	logger.info("##### " + joinPoint.getSignature() + " 정상케이스 #####");
    	
    	/*if(!returnVal.containsKey(NameEnum.RESULTCODE.toString())) {
    		returnVal.put(NameEnum.RESULTCODE.toString(), "1001");
        	returnVal.put(NameEnum.RESULTMSG.toString(), "요청처리를 성공적으로 수행했습니다.");
    	}*/
    	
    	logger.info("##### Return value : "+ returnVal + " #####");
    }
    
    /**
     * Method 에외 발생 시
     * @param joinPoint
     * @throws Exception
     */
    public void commonAfterThrow(JoinPoint joinPoint) throws Exception {
    	logger.info("##### " + joinPoint.getSignature() + " 예외 발생 #####");
    	
    	Object[] objs = joinPoint.getArgs();
    	
    	for(Object obj : objs) {
    		if(obj instanceof HttpServletResponse) {
    			// Response 객체
    			logger.info("response");
    			HttpServletResponse response = (HttpServletResponse)obj;
    			response.getWriter().write("error!!!!!!!!!!");
    		}
    	}
    }
    
    /**
     * API 후처리
     * 
     * @param joinPoint
     * @throws Exception
     */
    @After("execution(* com.lgu.ccss..*Controller.*(..))")
    public void commonAfter(JoinPoint joinPoint) throws Exception {
    }

}
