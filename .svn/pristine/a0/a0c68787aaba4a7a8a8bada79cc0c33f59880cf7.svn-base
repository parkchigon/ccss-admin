package com.lgu.ccss.common.enums;

/**
 * DB로 관리하기 힘든경우 공통된 오류 메시지를 관리를 위한 열거형
 * 보내는 쪽에서 메시지 형식으로 코드를 보내
 * 받는 쪽에서 해당 코드를 이용해 메시지를 찾아 처리한다.
 * to : throw new Exception(ERROR_CODE.LOGIN_ERR_NOT_FOUND_USER.getValue());
 * from :
 *   String code = exception.getMessage();
 *   ResultCodeEnum rc = ResultCodeEnum.valueOf(ResultCodeEnum.class, code);
 *   log.info("메시지 : {}", messageSource(rc.getValue())); 
 * 
 * @author kimhs
 *
 */
public enum ErrorCodeEnum {
    // 처리성공 코드
    SUCCESS("1001"),
    // 자료없음
    NOT_FOUND("1002"),
    // 처리실패 코드
    FAIL("1005"),
    // 잘못된 요청
    BAD_REQUEST("1006"),
    // Method를 사용할 수 없음
    METHOD_NOT_ALLOWED("1007"),
    // 접수할 수 없음
    NOT_ACCEPTABLE("1008"),
    // 인증오류
    UNAUTHORIZED("권한없음"),
    // 유효하지 않은 소셜 로그인 액세스 토큰 
    LOGIN_ERR_INVALID_API_ACCESS_TOKEN("유효하지 않은 소셜 ACCESS_TOKEN 입니다."),
    // 존재하지 않는 사용자
    LOGIN_ERR_NOT_FOUND_USER("2051")
    ;

    private String code;

    private ErrorCodeEnum(String code) {
        this.code = code;
    }

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
}
