package com.lgu.ccss.admin.login.service;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import lguplus.security.vulner.SecurityModule;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;












//import com.lgu.admin.admin.domain.SmsVO;
import com.lgu.ccss.admin.admin.domain.AdminVO;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.domain.EmailVO;
import com.lgu.ccss.common.utility.AES128Cipher;
import com.lgu.ccss.common.utility.DateUtil;
import com.lgu.ccss.common.utility.MessageAccessUtil;
import com.lgu.ccss.common.utility.TemporayPassword;

import devonframe.dataaccess.CommonDao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service("loginService")
public class LoginServiceImpl implements LoginService {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginServiceImpl.class);
	@Resource(name = "commonDao_oracle")
	private CommonDao commonDao_oracle;
	
	
	@Resource(name="messageUtil")
	private MessageAccessUtil messageUtil;
	
	@Resource(name="mailSender") 
	private JavaMailSender mailSender;

	
	/**
	 * Admin 아이디 찾기
	 * @param adminVO
	 * @return
	 * @throws Exception 
	 */
	public AdminVO checkFindId(AdminVO adminVO) throws Exception {
		String decName="";
		String decEmail="";
		if(StringUtils.isNotEmpty(adminVO.getMngrNm())) {
			//웹에서 암호화 한 비밀번호 복호화
			decName  = AES128Cipher.AES_Decode(adminVO.getMngrNm(), "abcdefghijklmnop");
			decEmail = AES128Cipher.AES_Decode(adminVO.getEmailAddr(), "abcdefghijklmnop");
			adminVO.setMngrNm(decName);
			adminVO.setEmailAddr(decEmail);
		}
		
		//Admin 회원 조회
		adminVO = commonDao_oracle.select("Login.checkFindId",adminVO);
		
		if(adminVO !=null){
			if(adminVO.getMngrNm().equals(decName)) {
				//일치
				adminVO.setResultType(Constants.YES);
			}else{
				// 불일치
				adminVO.setResultType(Constants.NO);
			}	
		}
		
		return adminVO;
	}
	
	/**
	 * Admin 비밀번호 찾기
	 * @param adminVO
	 * @return
	 * @throws Exception 
	 */
	public AdminVO checkFindPwd(AdminVO adminVO) throws Exception {
		boolean sendEmailResult=false;
		String decName ="";
		String decEmail="";
		if(StringUtils.isNotEmpty(adminVO.getMngrId())) {
			//웹에서 암호화 한 E-mail 복호화
			decName  = AES128Cipher.AES_Decode(adminVO.getMngrNm(), "abcdefghijklmnop");
			decEmail = AES128Cipher.AES_Decode(adminVO.getEmailAddr(), "abcdefghijklmnop");
			adminVO.setMngrNm(decName);
			adminVO.setEmailAddr(decEmail);
			
			//Admin 회원 조회
			adminVO = commonDao_oracle.select("Login.checkFindPwd",adminVO);
			
			if(adminVO !=null){
				
				if(adminVO.getAccountStatus().equals(Constants.ACCOUNT_LOCK)){
					
					adminVO.setResultType(Constants.ACCOUNT_LOCK);
					
				}else if(adminVO.getAccountStatus().equals(Constants.ACCOUNT_DISABLED)){ //계정 비활성화 
					
					adminVO.setResultType(Constants.ACCOUNT_DISABLED);
					
				}else if(adminVO.getMngrNm().equals(decName) && adminVO.getEmailAddr().equals(decEmail)) {
					//있을 겨우 임시 비밀번호 생성 및 E-mail 발송.
					//1)비밀 번호 히스토리 추가.
					adminVO.setBfrPassWd(adminVO.getPassWd());
					//1-1)임시 비밀번호 생성
					adminVO.setNewSecrNo(TemporayPassword.temporaryPassword(10));
					adminVO.setPassWd(SecurityModule.SHA512_Encrypt(adminVO.getNewSecrNo()));
					
					//2-1)DB업데이트 성공시 이메일 발송
					int result = commonDao_oracle.update("Login.updatePwd",adminVO);
					
					if(result > 0){
						try{
							//2)이메일 발송
							sendEmailResult = sendMail(makeEmailVO(adminVO));
							
						}catch(Exception e){
							logger.error("Send Mail Exception",e);
						}
						
						if(sendEmailResult){
							//2-2)이메일 발송 성공.
							adminVO.setResultType(Constants.YES);
						}else{
							//2-2)이메일 발송 실패시 안내 재시도 안내 문구
							adminVO.setResultType(Constants.RETRY);
							
						}
					}else{
						logger.info("DB Upate Fail !!");
						adminVO.setResultType(Constants.RETRY);
					}
				}else{
					
					// 정보 불일치
					adminVO.setResultType(Constants.NO);
				}
			}
		}
		return adminVO;
	}
	
	/**
	 * Admin 비밀번호 변경
	 * @param adminVO
	 * @return
	 * @throws Exception 
	 */
	public AdminVO updateAdminPwd(AdminVO adminVO) throws Exception {
		String decOldSecrNo="";
		String decNewSecrNo="";
		if(StringUtils.isNotEmpty(adminVO.getMngrId())) {
			//웹에서 암호화 한 비밀번호 복호화
			decOldSecrNo  = AES128Cipher.AES_Decode(adminVO.getOldSecrNoEnc(), "abcdefghijklmnop");
			decNewSecrNo =  AES128Cipher.AES_Decode(adminVO.getNewSecrNoEnc(), "abcdefghijklmnop");
			
			//LGU에서 제공받은 암화 모듈로 암화화 진행
			adminVO.setPassWd(SecurityModule.SHA512_Encrypt(decOldSecrNo));
			adminVO.setNewSecrNo(SecurityModule.SHA512_Encrypt(decNewSecrNo));
		}
		
		//Admin 회원 조회
		AdminVO	 resultLogin = commonDao_oracle.select("Login.checkAdminPwd",adminVO);
		if(resultLogin != null){
			
			if(resultLogin.getPassWd().equals(adminVO.getPassWd())) {
				//기본 비밀 번호 이력 셋팅
				adminVO.setBfrPassWd(adminVO.getPassWd());
				
				int rultCnt =  commonDao_oracle.update("Login.updateAdminPwd",adminVO);
				
				if(rultCnt > 0){
					adminVO.setResultType(Constants.YES);
				}else{
					adminVO.setResultType(Constants.FAIL);
				}
			
			}else{
				adminVO.setResultType(Constants.NO);
			}
			
		}else{
			//회원 정보 없음.
		}
		
		return adminVO;
	}
	
	
	/**
	 * Admin password 확인
	 * @param adminVO
	 * @return
	 * @throws Exception 
	 */
	public AdminVO checkAdminPwd(AdminVO adminVO) throws Exception {
		
		if(StringUtils.isNotEmpty(adminVO.getMngrId())) {
			//웹에서 암호화 한 비밀번호 복호화
			String decId = AES128Cipher.AES_Decode(adminVO.getMngrId(), "abcdefghijklmnop");
			
			//LGU에서 제공받은 암화 모듈로 암화화 진행
			adminVO.setMngrId(decId);
		}
		
		if(StringUtils.isNotEmpty(adminVO.getPassWd())) {
			//웹에서 암호화 한 비밀번호 복호화
			String decPw = AES128Cipher.AES_Decode(adminVO.getPassWd(), "abcdefghijklmnop");
			
			//LGU에서 제공받은 암화 모듈로 암화화 진행
			adminVO.setPassWd(SecurityModule.SHA512_Encrypt(decPw));
		}
		
		//Admin 회원 조회
		AdminVO	 resultLogin = commonDao_oracle.select("Login.checkAdminPwd",adminVO);
	
		if(resultLogin != null) {
			String masterAccounts = messageUtil.getMessage("admin.hipass.account");	
			//ID, PW 일치함
			if(resultLogin.getPassWd().equals(adminVO.getPassWd())) {
				

				//마스터 계정은 체크 하지 않음
				if(!masterAccounts.contains(resultLogin.getMngrId())) {
					//계정 상태 Check
					if( resultLogin.getUseYn().equals(Constants.YES) && (resultLogin.getAccountStatus().equals(Constants.ACCOUNT_NOMAL) ||  resultLogin.getAccountStatus().equals(Constants.IGNORE_LAST_LOGIN_DT))){
						
						//패스워드 디스플레이 여부  PW_MOD_DISP_YN 이면,  패스워드 변경 팝업 노출 할지 말지..
						if(resultLogin.getPwModDispYn().equals(Constants.YES)){
							resultLogin.setResultType(Constants.FAIL_ACCOUNT_CHG_PWD);
							return resultLogin;
						}
						
						//Fail Count > 5 
						if(resultLogin.getLoginFailCount() >= 5  ) {
							//로그인 실패!! 마스터에게 연락해야함
							resultLogin.setResultType(Constants.FAIL_ACCOUNT_LOCK);
							adminVO.setUpdId(Constants.SYSTEM);
							adminVO.setAccountStatus(Constants.ACCOUNT_LOCK);
							//계정 잠금 update
							commonDao_oracle.update("Login.updateAdminStatus",adminVO);
							return resultLogin;
						}
						
						
						//로그인 히스토리 확인 후 2달이 지났으면, 계정 잠금 // 제거 2018.06.15
						/*if(!resultLogin.getAccountStatus().equals(Constants.IGNORE_LAST_LOGIN_DT)){
							String lastLoginDt = commonDao_oracle.select("Login.checkLastLoginDt",adminVO);
							logger.debug("lastLoginDt :" + lastLoginDt);
							
							if(lastLoginDt !=null && !lastLoginDt.equals("")){
								
								String towMonthAgoDay = DateUtil.getCustomDate(DateUtil.getDate(),Constants.MONTH,2);
								logger.debug("towMonthAgoDay :" + towMonthAgoDay);
								
								if(towMonthAgoDay.compareTo(lastLoginDt) == 1){//앞에 변수가 크면 1, 작으면 -1, 같으면 0
									logger.debug("Mngr Id is +" + adminVO.getMngrId()  + "is Did Not Log in For Two Months. Change Account Status Lock");
									adminVO.setUpdId(Constants.SYSTEM);
									adminVO.setAccountStatus(Constants.ACCOUNT_LOCK);
									//계정 잠금 update
									commonDao_oracle.update("Login.updateAdminStatus",adminVO);
			
									resultLogin.setResultType(Constants.FAIL_ACCOUNT_TWO_MONTH_LOCK);
									return resultLogin;
								}
							}
						}*/
						
						
						//패스워드 만료일 Check
						if(StringUtils.isNotBlank(resultLogin.getPwChgDt())) {
							
							String day = messageUtil.getMessage("admin.password.change.day");
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
							Date latestDate = sdf.parse(resultLogin.getPwChgDt());
							Date currendDate = new Date();
							
							long diff = currendDate.getTime() - latestDate.getTime();
							long diffDays = diff / (24 * 60 * 60 * 1000);
							
							if(diffDays >= Long.parseLong(day)) {
								//비번 바꾸기 권고
								resultLogin.setResultType(Constants.PASSWORD_EXPIRED);
								return resultLogin;
							}
						}
						

						//인증 번호 갱신.
						String authNo = createAuthNo();
						adminVO.setSmsCertiNo(authNo);
						int updtResult = commonDao_oracle.update("Login.updateAuthNo",adminVO);

						/*if(updtResult == 1) {
							//인증번호 등록 성공시 문자 발송 등록
							
							SmsVO smsVO = new SmsVO();
							smsVO.setSmsSeq(smsSendHistorySeqGnrService.getNextStringId());
							smsVO.setSenderId("SYSTEM");
							smsVO.setSenderName("SYSTEM");
							smsVO.setSendType("I");
							smsVO.setContent("CCSS 서비스 관리자 인증번호는 " + authNo + "입니다.");
							smsVO.setReceiverMobileNum(resultLogin.getAdminMobileNum());
							smsVO.setSenderMobileNum("019114");
							smsVO.setReceiverType("M");			
							loginMapper.insertSendAuthSms(smsVO);
							
						}*/
						
						//로그인 실패 카운트 갱신
						adminVO.setLoginFailCount(0);
						commonDao_oracle.update("Login.updateLoginFailCount",adminVO);
						
						
					}else if(resultLogin.getAccountStatus().equals(Constants.ACCOUNT_LOCK)){ //계정 잠김 상태
						
						resultLogin.setResultType(Constants.FAIL_ACCOUNT_LOCK);
						
					}else if(resultLogin.getAccountStatus().equals(Constants.ACCOUNT_DISABLED)){ //계정 비활성화
						
						resultLogin.setResultType(Constants.FAIL_ACCOUNT_DISABLED);
						
					}else if(resultLogin.getAccountStatus().equals(Constants.ACCOUNT_PWD_LOCK)){ //비밀번호 잠김
						
						resultLogin.setResultType(Constants.FAIL_ACCOUNT_PWD_LOCK);
					}else if(resultLogin.getUseYn().equals(Constants.NO)){
						//Nothing
						resultLogin.setResultType(Constants.UN_USED_ID);
					}else{
						
					}
				}
					
				//로그인 이력 생성.
				commonDao_oracle.insert("Login.regLoginHistory",adminVO);
				
			} else {  //ID,PWD 불일치
				
				if(masterAccounts.contains(resultLogin.getMngrId())) {
					return null;
				}else{
					
					//로그인 실패 횟수 증가 처리
					int updateLoginFailCnt = resultLogin.getLoginFailCount()+1;
					String  accountLockCnt= messageUtil.getMessage("admin.login.lock.fail.count");
					if(updateLoginFailCnt > Integer.parseInt(accountLockCnt)){
						//resultLogin.setResultType(Constants.FAIL_ACCOUNT_LOCK_INFO);
						resultLogin.setResultType(Constants.FAIL_ACCOUNT_LOCK);
						adminVO.setAccountStatus(Constants.ACCOUNT_LOCK);
						commonDao_oracle.update("Login.updateAccountStatus",adminVO);
					}else{
						resultLogin.setResultType(Constants.FAIL_COUNT_NOT_OVER);
						
					}
					resultLogin.setLoginFailCount(updateLoginFailCnt);
					adminVO.setLoginFailCount(updateLoginFailCnt);
					commonDao_oracle.update("Login.updateLoginFailCount",adminVO);
					return resultLogin;
				}
			}
		} else {
			//아이디가 존재하지 않는 경우
			//Nothing
		}
		return resultLogin;
	}

	/**
	 * 로그인 인증번호 확인
	 * @param adminVO
	 * @return
	 * @throws BadPaddingException 
	 * @throws IllegalBlockSizeException 
	 * @throws InvalidAlgorithmParameterException 
	 * @throws NoSuchPaddingException 
	 * @throws NoSuchAlgorithmException 
	 * @throws UnsupportedEncodingException 
	 * @throws InvalidKeyException 
	 */
	public Map<String, Object> checkAuthNo(AdminVO adminVO) throws InvalidKeyException, UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		
		if(StringUtils.isNotEmpty(adminVO.getMngrId())) {
			//웹에서 암호화 한 비밀번호 복호화
			String decPw = AES128Cipher.AES_Decode(adminVO.getPassWd(), "abcdefghijklmnop");
			
			//LGU에서 제공받은 암화 모듈로 암화화 진행
			adminVO.setPassWd(SecurityModule.SHA512_Encrypt(decPw));
		}
		
		//sms 발송 가능한 시점에 주석 해제
//		if(loginMapper.checkAuthNo(adminVO) > 0) {
			resultMap.put(Constants.RESULT, Constants.YES);
			//로그인 성공시 실패카운트 초기화
			adminVO.setLoginFailCount(0);
			commonDao_oracle.update("Login.LoginFailCount",adminVO);
//		} else {
//			resultMap.put(Constants.RESULT, Constants.NO);
//		}
		return resultMap;

	}

	public String getMenuUrl(HashMap menuMap, Object[] programList) {

		String programUrl = "";
		ArrayList subMenuList = (ArrayList) menuMap.get("subNodeList");
		HashMap subMenuMap = new HashMap();
		if (subMenuList.size() > 0) {
			subMenuMap = (HashMap) subMenuList.get(0);
			String menuId = (String) subMenuMap.get("menuId");
			for (int i = 0; i < programList.length; i++) {
				Map programMap = (Map) programList[i];
				String programMenuId = (String) programMap.get("menuId");
				if (menuId.equals(programMenuId) && "Y".equals((String) programMap.get("stProgramYn"))) {
					programUrl = (String) programMap.get("programUrl");
					break;
				}
			}
		} else {
			programUrl = (String) menuMap.get("programUrl");
		}

		if (programUrl == null || "".equals(programUrl))
			programUrl = getMenuUrl(subMenuMap, programList);

		return programUrl;
	}
	
	
	
	public String createAuthNo() throws Exception {
		Random rd = new Random();
		int max, min;
		max = 99999; min = 10000;
		String ramdomNumber = String.valueOf(rd.nextInt(max - min +1) + min);
		return ramdomNumber;
	}
	
	
	public boolean sendMail(EmailVO emailVO) { 
		logger.info("## emailVO:"+emailVO.toString());
		
		boolean sendEmailResult = true;
		try { 
				MimeMessage message = mailSender.createMimeMessage(); 
				
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8"); 
				messageHelper.setTo(emailVO.getReceiver()); 
				messageHelper.setText(emailVO.getContent()); 
				messageHelper.setFrom(emailVO.getFrom()); 
				messageHelper.setSubject(emailVO.getSubject());	// 메일제목은 생략이 가능하다 
				mailSender.send(message); 
			} 
		catch(Exception e){ 
			logger.error("sendMail Exception:",e);
			sendEmailResult=false;
		} 
		return sendEmailResult; 
	}
	
	
	public EmailVO makeEmailVO(AdminVO adminVO){
		EmailVO email = new EmailVO();
		email.setFrom(messageUtil.getMessage("email.from.addr"));	// from
		email.setReceiver(adminVO.getEmailAddr());  				// 받는사람:가입유저
		email.setSubject(messageUtil.getMessage("email.subject")); 	// 메일 제목 properties  파일 참조
		
		email.setContent( adminVO.getMngrId() 
						+ messageUtil.getMessage("email.content.pre.massage")
						+ adminVO.getNewSecrNo()
						+ messageUtil.getMessage("email.contnet.middle.massage")
						+ messageUtil.getMessage("email.content.line.break")
						+ messageUtil.getMessage("email.contnet.post.massage"));
		
		email.setSubject(messageUtil.getMessage("email.from.addr"));  //보내는 메일 주소 및 도메인
		adminVO.setNewSecrNo("");
		return email;
	}
	

		
}
