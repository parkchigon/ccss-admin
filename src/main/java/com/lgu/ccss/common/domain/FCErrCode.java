package com.lgu.ccss.common.domain;


/**
 * 오류 코드 정의 <br/>
 * <br/>
 *
 * @author hykwak
 */
public enum FCErrCode {

	/** Error Code 정의 */
	INTERNAL_ERROR("500", "서버 내부 오류"),
	NOT_FOUND_ERROR("404", "파일을 찾을 수 없습니다."),
	REQUEST_ERROR("400", "Request Error"),
	DATABASE_ERROR("501", "데이터 베이스 오류 입니다."),
	NOT_FOUND_ITEM_REWARD("404", "사용할 수 있는 보상아이템이 없습니다."),
	FAIL_TO_MAKE_SHORT_URL("600", "URL 생성 시 오류가 발생하였습니다."),

	// 회원 API(1xxx)
	NOT_FOUND_USER_ID("1001","존재하지 않는 사용자 아이디 입니다."),
	NOT_MATCHED_USER_PWD("1002","입력하신 비밀번호가 다릅니다."),
	NOT_VALID_USER_ID("1003","유효하지 않은 사용자 아이디 입니다."),
	NOT_VALID_NICKNAME("1004", "유효하지 않은 닉네임입니다."),
	NOT_FOUND_USER("1005", "사용자 정보를 찾을 수 없습니다."),
	NOT_CHANGE_USER_PWD("1006", "사용자 비밀번호 찾기 실패."),
	OVERLAP_USER_MOBILE_NO("1007","이미 사용중인 전화번호입니다."),
	NOT_VALID_AUTH("1008","입력하신 인증번호가 일치하지 않습니다. 다시한번 확인하시고 입력해 주시기 바랍니다."),
	TIMEOVER_AUTH("1009","인증번호 입력 유효 시간이 초과되었습니다. 인증번호를 재발급받으시기 바랍니다."),
	NOT_ACTIVE_USER("1010","현재 아이디는 사용하실 수 없습니다. 관리자에게 문의하세요"),
	FAIL_TO_UPDATE_PROFILEIMAGE("1011","이미지 등록 실패"),
	OVERLAP_USER_EMAIL("1012","이미 사용중인 이메일 주소 입니다."),
	ADMIN_STATUS_REQUEST("1013","승인요청 중입니다."),
	ADMIN_STATUS_PAUSE("1014","일시정지 상태 입니다."),
	;

    /** The code. */
    private String code;

    /** The message. */
    private String message;

    /**
     * Instantiates a new personal exception code.
     *
     * @param code
     *            the code
     * @param message
     *            the message
     */
    private FCErrCode(String code, String message) {
        this.code = code;
        this.message = message;
    }

    /**
     * Gets the code.
     *
     * @return the code
     */
    public String getCode() {
        return code;
    }

    /**
     * Sets the code.
     *
     * @param code
     *            the new code
     */
    public void setCode(String code) {
        this.code = code;
    }

    /**
     * Gets the message.
     *
     * @return the message
     */
    public String getMessage() {
        return message;
    }

    /**
     * Sets the message.
     *
     * @param message
     *            the new message
     */
    public void setMessage(String message) {
        this.message = message;
    }

}
