package com.lgu.ccss.common.utility;

import java.util.regex.Pattern;

public class CommonUtil {

    /**
     * 신규 비밀번호 생성<br/>
     * 현재 시간을 기준으로 신규 비밀번호를 생성한다.
     * 
     * @return
     */
    public static String makeNewPwd() {

        String temp = String.valueOf(System.currentTimeMillis());

        return temp.substring(temp.length() - 5);
    }

    /**
     * 전화번호 인증번호 생성<br/>
     * 현재 시간을 기준으로 신규 비밀번호를 생성한다.
     * 
     * @return
     */
    public static String makeNewAuth() {

        String temp = String.valueOf(System.currentTimeMillis());

        return temp.substring(temp.length() - 5);
    }

    /**
     * 현재 실행 중인 메소드 명을 반환한다.
     * 
     * @return
     */
    public static String getProcessingMethodName() {

        StackTraceElement[] stacks = new Throwable().getStackTrace();

        String currentProcessing = "";

        if (stacks.length > 0) {
            StackTraceElement currentStack = stacks[1];
            currentProcessing = currentStack.getClassName() + " : " + currentStack.getMethodName() + "<br/>";
        }

        return currentProcessing;
    }
    
    
	// 휴대폰번호 정규식 체크
	public static boolean isPhone(String str) {
		String regex = "^01(?:0|1|[6-9])(?:\\d{3}|\\d{4})\\d{4}$";
		return Pattern.matches(regex, str);
	}

	// 이메일 정규식 체크
	public static boolean isEmail(String str) {
		String regex = "[\\w\\~\\-\\.]+@[\\w\\~\\-]+(\\.[\\w\\~\\-]+)+";
		return Pattern.matches(regex, str);
	}
}
