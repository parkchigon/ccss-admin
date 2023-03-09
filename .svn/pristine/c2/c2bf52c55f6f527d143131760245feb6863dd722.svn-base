/**
 * @(#)TokenUtils.java
 */
package com.lgu.ccss.common.utility;

import org.apache.commons.codec.digest.DigestUtils;

/**
 * 각종 Token 값을 생성한다.
 */
public class TokenUtils {

    /**
     * 랜덤한 인증번호 생성하여 반화한다.
     * 
     * @return
     */
    public static String makeRandomAuthNum() {

        java.util.Random rand = new java.util.Random();
        String random = "";
        for (int i = 0; i < 6; i++) {
            random += rand.nextInt(10);
        }
        return random;
    }

    /**
     * 랜덤한 패스워드를 생성하여 반환한다.
     * 
     * @return
     */
    public static String makeRandomPassword() {

        char name[] = new char[4];// 이름 name[0]은 65-90 //나머지 97-122
        String names = "";
        int ran;
        int ranUpper;
        int ranLower;

        for (int i = 0; i < name.length; ++i) { // 이름지정
            ran = (int) (Math.random() * 26); // 0-25
            ranUpper = ran + 65; // 대문자
            ranLower = ran + 97; // 소문자
            if (i == 0) {
                names += name[0] = (char) ranUpper;
            } else {
                names += name[i] = (char) ranLower;
            }
        }

        java.util.Random rand = new java.util.Random();
        String random = "";
        for (int i = 0; i < 4; i++) {
            random += rand.nextInt(10);
        }
        return names + random;
    }

    /**
     * 회원의 auth_key 를 생성하여 반환한다. 64자리 코드
     * 
     * @param login_id
     * @return
     */
    public static String makeAuthKey(String memberId) {
        return DigestUtils.sha256Hex(memberId + System.nanoTime());
    }
    
    
    public static void main(String args[]) {
        System.out.println(TokenUtils.makeAuthKey("FLLKING"));
    }
    
    
}
