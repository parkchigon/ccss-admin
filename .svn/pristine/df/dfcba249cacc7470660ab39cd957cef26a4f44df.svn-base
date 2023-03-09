package com.lgu.ccss.common;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;
import javax.validation.ValidationException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceAware;
import org.springframework.core.Ordered;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.annotation.support.HandlerMethodInvocationException;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.NoSuchRequestHandlingMethodException;

import com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException;
import com.lgu.ccss.common.domain.FCException;
/**
 * The class SngpHandlerExceptionResolver - exception 처리
 * 
 * @author hykwak
 */
public class WebHandlerExceptionResolver implements MessageSourceAware, HandlerExceptionResolver, Ordered {

    protected Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    protected MessageSource messageSource;

    private int order = Ordered.LOWEST_PRECEDENCE;

    public void setMessageSource(MessageSource messageSource) {
        this.messageSource = messageSource;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public int getOrder() {
        return this.order;
    }

    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception exception) {

        ModelAndView mav = new ModelAndView("error");

        String resultCode = "500";
        String resultMessage = "서버 내부오류";

        if (exception instanceof SQLException) {
            resultCode = "500";
            resultMessage += "[DB]";
        } else if (exception instanceof MissingServletRequestParameterException) {
            resultCode = "501";
            resultMessage += "[Servlet]";
            // MissingServletRequestParameterException mpe =
            // (MissingServletRequestParameterException)exception;
            // mpe.getParameterName();
            // mpe.getParameterType();
        } else if (exception instanceof BindException) {
            resultCode = "500";
            BindingResult bindingResult = ((BindException) exception).getBindingResult();
            List<ObjectError> errors = bindingResult.getAllErrors();
            if (errors.size() > 0) {
                FieldError fieldError = bindingResult.getFieldErrors().get(0);
                resultMessage = getMessage(fieldError);
                // logger.error(getMessage(fieldError));
            }
        } else if (exception instanceof ValidationException) {
            resultCode = "500";
        } else if (exception instanceof IllegalArgumentException) {
            resultCode = "500";
        } else if (exception instanceof FCException) {
            resultCode = ((FCException) exception).getCode();
            resultMessage = exception.getMessage();
        } else if (exception instanceof NullPointerException) {
            resultCode = "500";
        } else if (exception instanceof UnrecognizedPropertyException) {
            resultCode = "500";
        } else if (exception instanceof ConstraintViolationException) {
            resultCode = "500";
        } else if (exception instanceof MethodArgumentNotValidException) {
            resultCode = "500";
            BindingResult bindingResult = ((MethodArgumentNotValidException) exception).getBindingResult();
            List<ObjectError> errors = bindingResult.getAllErrors();
            if (errors.size() > 0) {
                FieldError fieldError = bindingResult.getFieldErrors().get(0);
                resultMessage = getMessage(fieldError);
            }
        } else if (exception instanceof HttpRequestMethodNotSupportedException) { // 400
            resultCode = "400";
            resultMessage = "지원하지 않는 메소드 입니다.";
        } else if (exception instanceof NumberFormatException) { // 400
            resultCode = "400";
            resultMessage = "데이터 입력형식을 확인해 주세요";
        } else if (exception instanceof ServletRequestBindingException) { // 400
            resultCode = "400";
            resultMessage = "데이터 입력형식을 확인해 주세요";
        } else if (exception instanceof NoSuchRequestHandlingMethodException) { // 404
            resultCode = "404";
            resultMessage = "Not Found";
        } else if (exception instanceof HttpMediaTypeNotSupportedException) { // 500
            resultCode = "500";
            resultMessage = "서버 내부오류";
        } else if (exception instanceof HttpMessageNotReadableException) { // 500
        	resultCode = "500";
            resultMessage = "서버 내부오류";
        } else if (exception instanceof HandlerMethodInvocationException) {
            resultCode = "500";
        } else { // 기타 Exception
            resultCode = "500";
        }

        logger.error(request.getRequestURI(), exception);

        return mav;
    }

    /**
     * 프로퍼티 파일에 정의된 메시지를 가져오기
     * 
     * @param code
     *            메시지 코드
     * @return 메시지
     */
    public String getMessage(String code) {
        return getMessage(code, null, null);
    }

    /**
     * 프로퍼티 파일에 정의된 메시지를 가져오기
     * 
     * @param code
     *            메시지 코드
     * @param args
     *            {0} 으로 정의 된 매개변수
     * @return 메시지
     */
    public String getMessage(String code, Object[] args) {
        return getMessage(code, args, null);
    }

    /**
     * 프로퍼티 파일에 정의된 메시지를 가져오기
     * 
     * @param code
     *            메시지 코드
     * @param defaultMessage
     *            디폴트 메시지
     * @return 메시지
     */
    public String getMessage(String code, String defaultMessage) {
        return getMessage(code, null, defaultMessage);
    }

    /**
     * 프로퍼티 파일에 정의된 메시지를 가져오기
     * 
     * @param code
     *            메시지 코드
     * @param args
     *            {0} 으로 정의 된 매개변수
     * @param defaultMessage
     *            디폴트 메시지
     * @return 메시지
     */
    public String getMessage(String code, Object[] args, String defaultMessage) {
        return messageSource.getMessage(code, args, defaultMessage, null);
    }

    /**
     * 에러 메시지 가져오기
     * 
     * @param error
     * @return
     */
    public String getMessage(ObjectError error) {
        String message = null;
        for (String code : error.getCodes()) {
            message = getMessage(code, error.getArguments());
            if (message != null)
                break;
        }
        if (message == null)
            message = error.getDefaultMessage();
        return message;
    }

}
