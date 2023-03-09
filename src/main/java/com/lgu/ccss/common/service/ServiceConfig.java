package com.lgu.ccss.common.service;

import java.util.HashMap;

import com.lgu.ccss.common.utility.XMLUtil;


public class ServiceConfig {
	
    /**
     * serviceInit.xml 파일 설정값
     */
    public static XMLUtil xu;
    /**
     * 브라우저 타이틀
     */
    public static String SERVICE_TITLE = "";

    /**
     * 로그인 페이지
     */
    public static String SERVICE_LOGIN_PAGE = "";

    /**
     * 관리자 로그인 페이지
     */
    public static String SERVICE_ADMIN_LOGIN_PAGE = "";

    /**
     * 사용자 MAIN 페이지
     */
    public static String SERVICE_MAIN_PAGE = "";

    /**
     * 기본날짜 포멧
     */
    public static String FORMAT_DATE = "";

    /**
     * 기본날짜시간 포멧
     */
    public static String FORMAT_DATETIME = "";
    
    /**
     * 페이징 블럭사이즈
     */
    public static int BLOCK_SIZE = 0;

    /**
     * 페이징 리스트사이즈
     */
    public static int LIST_SIZE = 0;

	/**
	 * 세션키 아이디
	 */
	public static String SESSION_KEY_USER_ID = "";

	/**
	 * 세션키 이름
	 */
	public static String SESSION_KEY_USER_NAME = "";   
    
    /**
     * 페이징 HTML 템플릿소스
     */
    public static HashMap<String,Object> PAGING_MAP = new HashMap<String,Object>();

    /**
     * 페이징 JAVASCRIPT
     */
    public static String PAGING_SCRIPT = "";

    /**
     * 사이트별 메뉴정보
     */
    @SuppressWarnings("rawtypes")
    public static HashMap MENU_MAP;    
    
    /**
     * 회원 가입시 이메일 인증 사용유무
     */
    public static String EMAIL_CERT_CHECK_YN = "";

    /**
     * 회원 인증시 ATUH 객체 세션 사용 유무
     */
    public static String AUTH_SESSION_USE_YN = "";    
}
