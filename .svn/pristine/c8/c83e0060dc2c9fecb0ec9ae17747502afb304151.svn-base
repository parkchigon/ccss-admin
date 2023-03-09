package com.lgu.ccss.common.exception;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.hsqldb.lib.HashMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.TypeMismatchException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.ModelMap;
import org.springframework.web.HttpMediaTypeNotAcceptableException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.NoSuchRequestHandlingMethodException;

import com.fasterxml.jackson.core.JsonParseException;
import com.lgu.ccss.common.enums.ErrorCodeEnum;
import com.lgu.ccss.common.enums.NameEnum;
import com.lgu.ccss.common.utility.MessageAccessUtil;

@ControllerAdvice
public class CommonControllerAdvice {
	protected final Logger log = LoggerFactory.getLogger(CommonControllerAdvice.class);

	@Autowired
	@Qualifier("message")
	private MessageAccessUtil messageUtil;

	private String ERROR_CODE_PREFIX = "error";

	/**
	 * 공통 에러
	 * @param ex
	 * @return
	 */
	/*@ExceptionHandler({Exception.class, BizException.class})
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	public String handleCommonException(Exception ex) {
		// 500에러
		log.error("", ex);

		ErrorCodeEnum code = ErrorCodeEnum.FAIL;

		String message = getMessageByCode(code.getCode());

		return createErrorMap(code.getCode(), message);
	}*/
	

	@ExceptionHandler({MethodArgumentNotValidException.class, BadRequestException.class, TypeMismatchException.class})
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public String handleMethodArgumentNotValidException(Exception ex) {
		// 400에러
		log.error("", ex);

		ErrorCodeEnum code = ErrorCodeEnum.BAD_REQUEST;

		String message = getMessageByCode(code.getCode());

		return createErrorMap(code.getCode(), message);
	}
	
	@ExceptionHandler({devonframe.exception.DevonException.class})
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public void abnomalArgumentNotValidException(Exception ex) {
		// 400에러
		log.error("", ex);

		ErrorCodeEnum code = ErrorCodeEnum.BAD_REQUEST;

		String message = getMessageByCode(code.getCode());

		//return createErrorMap(code.getCode(), message);
		//return  "forward:/common/error/400.do";
	}
	

	@ExceptionHandler({NoSuchRequestHandlingMethodException.class})
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handleNoSuchRequestHandlingMethodException(NoSuchRequestHandlingMethodException ex) {
		// 404에러
		//log.error("", ex);

		ErrorCodeEnum code = ErrorCodeEnum.NOT_FOUND;

		String message = getMessageByCode(code.getCode());

		return createErrorMap(code.getCode(), message);
	}
	
	@ExceptionHandler({HttpMediaTypeNotAcceptableException.class})
	@ResponseStatus(HttpStatus.NOT_ACCEPTABLE)
	public String handleHttpMediaTypeNotAcceptableException(HttpMediaTypeNotAcceptableException ex) {
		// 406에러
		//log.error("", ex);

		ErrorCodeEnum code = ErrorCodeEnum.NOT_ACCEPTABLE;

		String message = getMessageByCode(code.getCode());

		return createErrorMap(code.getCode(), message);
	}
	
	@ExceptionHandler({JsonParseException.class})
	@ResponseStatus(HttpStatus.NOT_ACCEPTABLE)
	public String handleJsonParseException(JsonParseException ex) {
		// 406에러
		//log.error("", ex);

		ErrorCodeEnum code = ErrorCodeEnum.NOT_ACCEPTABLE;

		String message = getMessageByCode(code.getCode());

		return createErrorMap(code.getCode(), message);
		
	}
	
	@ExceptionHandler({HttpRequestMethodNotSupportedException.class})
	@ResponseStatus(HttpStatus.METHOD_NOT_ALLOWED)
	public String handleMethodNotAllowedException(HttpRequestMethodNotSupportedException ex) {
		// 405에러
		//log.error("", ex);

		ErrorCodeEnum code = ErrorCodeEnum.METHOD_NOT_ALLOWED;
		
		String message = getMessageByCode(code.getCode());

		return createErrorMap(code.getCode(), message);
	}

	/**
	 * 권한없음 에러
	 * @param ex
	 * @return
	 */
	@ExceptionHandler(MenuAuthorizedException.class)
	@ResponseStatus(HttpStatus.UNAUTHORIZED)
	public String handleAuthorizedExceptionException(HttpServletRequest request, HttpServletResponse response, MenuAuthorizedException ex) {
		// 401
		//log.error("", ex);
		//ErrorCodeEnum code = ErrorCodeEnum.UNAUTHORIZED;
		//String message = getMessageByCode(code.getCode());
		//return createAuthErrorMap((String) code.getCode(), message);
		return  "forward:/common/error/401.do";
		
	}
	
	
	
	/**
	 * 
	 * Excpetion 맵을 생성
	 * 
	 * @param value
	 * @param movedPermanentlyCode
	 * @param errorMessage
	 * @return
	 */
	private String createAuthErrorMap(String resultCode, String resultMessage) {
		ModelMap model = new ExtendedModelMap();
		model.put(NameEnum.RESULTCODE.toString(), resultCode);
		model.put(NameEnum.RESULTMSG.toString(), resultMessage);
		
		return "/common/error/401";
	}
	/**
	 * 
	 * Excpetion 맵을 생성
	 * 
	 * @param value
	 * @param movedPermanentlyCode
	 * @param errorMessage
	 * @return
	 */
	private String createErrorMap(String resultCode, String resultMessage) {
		ModelMap model = new ExtendedModelMap();
		model.put(NameEnum.RESULTCODE.toString(), resultCode);
		model.put(NameEnum.RESULTMSG.toString(), resultMessage);
		
		return "/common/error/500";
	}
	
	
	
	/**
	 * ResultCodeEnum에 정의된 코드로 message.properties에서 메시지를 찾아 반환
	 * @param code
	 * @return
	 */
	private String getMessageByCode(String code) {
		if(StringUtils.isNotEmpty(code) && code.length() == 4) {
			String apiId = code.substring(0, 3);
			String order = code.substring(3, 4);
			
			String key = new StringBuffer(ERROR_CODE_PREFIX).append(".").append(apiId).append(".").append(order).toString();
			
			String message = messageUtil.getMessage(key);
			
			if(StringUtils.isEmpty(message)) {
				// message.properties에 해당 코드의 메시지가 없으면 code를 넘긴다.
				message = code;
			}
			
			return message;
		}
		
		return "";
	}
}
