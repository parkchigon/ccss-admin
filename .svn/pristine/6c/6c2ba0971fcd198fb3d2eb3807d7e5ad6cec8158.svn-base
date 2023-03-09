package com.lgu.ccss.common.domain.response;

/**
 * result Status
 * 
 *
 */
public enum ResultCode {

    SUCCESS("200", "응답 성공"), // 응답 성공
    REQUEST_ERROR("400", "필수 parameter 오류"), // 필수 parameter 오류
    AUTH_ERROR("401", "권한 없음"), // 권한 없음
    FORBIDDEN("403", "Forbidden"), // Forbidden
    NOT_FOUND("404", "Not Found"), // Not Found
    SYSTEM_ERROR("500", "서버 내부오류"), // 서버 내부오류
    TIMEOUT_ERROR("504", "Timeout 발생"), // Timeout 발생
    REQUEST_VALUE_ERROR("405", "parameter value 에러"); // 비필수 parameter value 에러

    private final String value;

    private final String description;

    private ResultCode(String value, String description) {
        this.value = value;
        this.description = description;
    }

    public String getValue() {
        return value;
    }

    public String getDescription() {
        return description;
    }

    public static ResultCode enumOf(String value) {
        if (value == null)
            return null;
        else if (value.equals("200"))
            return SUCCESS;
        else if (value.equals("400"))
            return REQUEST_ERROR;
        else if (value.equals("401"))
            return AUTH_ERROR;
        else if (value.equals("403"))
            return FORBIDDEN;
        else if (value.equals("404"))
            return NOT_FOUND;
        else if (value.equals("500"))
            return SYSTEM_ERROR;
        else if (value.equals("504"))
            return TIMEOUT_ERROR;
        else if (value.equals("405"))
            return REQUEST_VALUE_ERROR;
        else
            return null;
    }
}
