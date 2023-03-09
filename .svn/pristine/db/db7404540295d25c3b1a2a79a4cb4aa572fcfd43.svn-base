package com.lgu.ccss.admin.admin.service;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.feelingk.UniqueKeyUtil;
import com.lgu.ccss.admin.admin.domain.AdminPagingVO;
import com.lgu.ccss.admin.admin.domain.AdminVO;
import com.lgu.ccss.admin.login.service.LoginServiceImpl;
import com.lgu.ccss.admin.system.role.domain.RoleVO;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.AES128Cipher;
import com.lgu.ccss.common.utility.SessionUtil;
import com.lgu.ccss.common.utility.TemporayPassword;

import devonframe.dataaccess.CommonDao;
import lguplus.security.vulner.SecurityModule;

@Service("adminService")
public class AdminServiceImpl implements AdminService {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminServiceImpl.class); 
	
    @Resource(name = "commonDao_oracle")
    private CommonDao commonDao_oracle;
    
    @Resource(name = "loginService")
	private LoginServiceImpl loginService;
	/**
	 * 운영자 리스트 카운트
	 * @param adminVO
	 * @return
	 */
	public int selectAdminListCnt(AdminVO adminVO) throws Exception{
	    return commonDao_oracle.select("Admin.selectAdminListCnt",adminVO);
	}


	/**
	 * 운영자 리스트 조회
	 * @param adminVO
	 * @return
	 */
	public Map<String, Object> selectAdminList(AdminVO adminVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		AdminVO supserAdminVO = commonDao_oracle.select("Admin.selectSuperAdmin",adminVO);
		supserAdminVO.setMngrNm(userInfoMasking(supserAdminVO.getMngrNm(),"name"));
		supserAdminVO.setClphNo(userInfoMasking(supserAdminVO.getClphNo(),"ctn"));
		supserAdminVO.setEmailAddr(userInfoMasking(supserAdminVO.getEmailAddr(),"email"));
		
		List<AdminVO> resultList = commonDao_oracle.selectList("Admin.selectAdminList",adminVO);
		
		for(AdminVO tempVO : resultList){
			
			//String mngrNm = tempVO.getMngrNm();
			
			tempVO.setMngrNm(userInfoMasking(tempVO.getMngrNm(),"name"));
			//String clphNo = tempVO.getClphNo();
			tempVO.setClphNo(userInfoMasking(tempVO.getClphNo(),"ctn"));
			//String emailAddr = tempVO.getEmailAddr();
			tempVO.setEmailAddr(userInfoMasking(tempVO.getEmailAddr(),"email"));
			
		}
		
		
		int totalCount = commonDao_oracle.select("Admin.selectAdminListCnt",adminVO);
		
		resultMap.put("supserAdminVO", supserAdminVO);
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);
		
		
		//리스트 검색 조건.
		if(String.valueOf(adminVO.getSearchType()) !=null && String.valueOf(adminVO.getSearchType()).equals("")){
			resultMap.put("searchType", String.valueOf(adminVO.getSearchType()));
		}
		
		if(String.valueOf(adminVO.getSearchValue()) !=null  && String.valueOf(adminVO.getSearchValue()).equals("")){
			resultMap.put("searchValue", String.valueOf(adminVO.getSearchValue()));
		}
		
		return resultMap;
	}


	/**
	 * 운영자 등록
	 * @param adminVO
	 * @throws BadPaddingException 
	 * @throws IllegalBlockSizeException 
	 * @throws InvalidAlgorithmParameterException 
	 * @throws NoSuchPaddingException 
	 * @throws NoSuchAlgorithmException 
	 * @throws UnsupportedEncodingException 
	 * @throws InvalidKeyException 
	 */
	public  Map<String, Object> insertAdmin(AdminVO adminVO) throws InvalidKeyException, UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		//웹에서 암호화 한 비밀번호 복호화
		String decPw = AES128Cipher.AES_Decode(adminVO.getPassWd(), "abcdefghijklmnop");
		String ctn  =AES128Cipher.AES_Decode(adminVO.getClphNo(), "abcdefghijklmnop");
		//adminVO.setAdminSeq(UniqueKeyUtil.getUniKey());
		
		String decMngrId = AES128Cipher.AES_Decode(adminVO.getMngrId(), "abcdefghijklmnop");
		String decMngrNm =AES128Cipher.AES_Decode(adminVO.getMngrNm(), "abcdefghijklmnop");
		String decEmailAddr = AES128Cipher.AES_Decode(adminVO.getEmailAddr(), "abcdefghijklmnop");
		
		//LGU에서 제공받은 암화 모듈로 암화화 진행
		adminVO.setPassWd(SecurityModule.SHA512_Encrypt(decPw));
		adminVO.setBfrPassWd(SecurityModule.SHA512_Encrypt(decPw));
		adminVO.setClphNo(ctn);
		adminVO.setMngrId(decMngrId);
		adminVO.setMngrNm(decMngrNm);
		adminVO.setEmailAddr(decEmailAddr);
		
		if(!validationPwd(decPw)){
			resultMap.put(Constants.RESULT, Constants.NO);
			resultMap.put("sayMessage", "패스워드는 숫자,영문자,특수문자를 혼용 8자리 이상을 사용 하여야 합니다.");
			return resultMap;
		}
		
		if(!idIncludCtn(adminVO.getClphNo(),decPw )){
			resultMap.put(Constants.RESULT, Constants.NO);
			resultMap.put("sayMessage", "전화번호가 포함된 비밀번호는 사용하실 수 없습니다.");
			return resultMap;
		}
		
		if(!idIncludCheck(adminVO.getMngrId(),decPw )){
			resultMap.put(Constants.RESULT, Constants.NO);
			resultMap.put("sayMessage", "아이디가 포함된 비밀번호는 사용하실 수 없습니다.");
			return resultMap;
		}
		
		if(checkContinuous3Character(decPw)){
			resultMap.put(Constants.RESULT, Constants.NO);
			resultMap.put("sayMessage", "비밀번호에 같은 문자를 연속으로 3번 이상 사용하실 수 없습니다.");
			return resultMap;
		}
		
		
		if(!emailValidationCheck(adminVO.getEmailAddr())){
			resultMap.put(Constants.RESULT, Constants.NO);
			resultMap.put("sayMessage", "이메일 형식이 올바르지 않습니다.");
			return resultMap;
		}
		
		if(adminVO.getIpAddr() !=null &&  adminVO.getIpAddr() !=""){
			if(!ipValidationCheck(adminVO.getIpAddr())){
				resultMap.put(Constants.RESULT, Constants.NO);
				resultMap.put("sayMessage", "ip 형식이 올바르지 않습니다.");
				return resultMap;
			}
		}
		

		commonDao_oracle.insert("Admin.insertAdmin",adminVO);
		
		//TB_MNGR_GROUP_MPNG 테이블 insert 
		RoleVO roleVO = new RoleVO();
		roleVO.setMngrGrpId(adminVO.getMngrLevel());
		String mngrGrpMapNm = UniqueKeyUtil.getUniKey();
		roleVO.setMngrGrpMapNm(mngrGrpMapNm);
		roleVO.setMngrId(adminVO.getMngrId());
		roleVO.setRegId(adminVO.getRegId());
		roleVO.setUpdId(adminVO.getUpdId());
		
		//MNGR_GRP_MAP_NM
		commonDao_oracle.insert("Role.insertAdminGroupMpng",roleVO);
		
		resultMap.put(Constants.RESULT, Constants.YES);
		
		return resultMap;
	}


	/**
	 * 운영자 수정
	 * @param adminVO
	 * @throws BadPaddingException 
	 * @throws IllegalBlockSizeException 
	 * @throws InvalidAlgorithmParameterException 
	 * @throws NoSuchPaddingException 
	 * @throws NoSuchAlgorithmException 
	 * @throws UnsupportedEncodingException 
	 * @throws InvalidKeyException 
	 */
	public Map<String, Object> updateAdmin(AdminVO adminVO) throws InvalidKeyException, UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if(!emailValidationCheck(adminVO.getEmailAddr())){
			resultMap.put(Constants.RESULT, Constants.NO);
			resultMap.put("sayMessage", "이메일 형식이 올바르지 않습니다.");
			return resultMap;
		}
		
		if(StringUtils.isNoneEmpty(adminVO.getPassWd())) {
			//웹에서 암호화 한 비밀번호 복호화
			String decPw = AES128Cipher.AES_Decode(adminVO.getPassWd(), "abcdefghijklmnop");
			
			
			if(!validationPwd(decPw)){
				resultMap.put(Constants.RESULT, Constants.NO);
				resultMap.put("sayMessage", "패스워드는 숫자,영문자,특수문자를 혼용 8자리 이상을 사용 하여야 합니다.");
				return resultMap;
			}

			if(!idIncludCtn(adminVO.getClphNo(),decPw )){
				resultMap.put(Constants.RESULT, Constants.NO);
				resultMap.put("sayMessage", "전화번호가 포함된 비밀번호는 사용하실 수 없습니다.");
				return resultMap;
			}
			
			if(!idIncludCheck(adminVO.getMngrId(),decPw )){
				resultMap.put(Constants.RESULT, Constants.NO);
				resultMap.put("sayMessage", "아이디가 포함된 비밀번호는 사용하실 수 없습니다.");
				return resultMap;
			}
			
			if(checkContinuous3Character(decPw)){
				resultMap.put(Constants.RESULT, Constants.NO);
				resultMap.put("sayMessage", "비밀번호에 같은 문자를 연속으로 3번 이상 사용하실 수 없습니다.");
				return resultMap;
			}
		
			if(adminVO.getIpAddr() !=null){
				if(!ipValidationCheck(adminVO.getIpAddr())){
					resultMap.put(Constants.RESULT, Constants.NO);
					resultMap.put("sayMessage", "ip 형식이 올바르지 않습니다.");
					return resultMap;
				}
			}
			
			//LGU에서 제공받은 암화 모듈로 암화화 진행
			adminVO.setPassWd(SecurityModule.SHA512_Encrypt(decPw));
			
			// 비밀번호 이력 관리 (변경전 비밀 번호)
			AdminVO adminInfo = commonDao_oracle.select("Admin.selectAdminDetail",adminVO);
			String adminPwHist = adminInfo.getBfrPassWd();
			
			// 이전에 동일한 비밀번호로 변경한 이력이 있을 경우
			if(StringUtils.isNotBlank(adminPwHist)) {
				//if(adminPwHist.indexOf(adminVO.getPassWd()) > -1) {
				if(adminPwHist.equals(adminVO.getPassWd())) {
					resultMap.put(Constants.RESULT, "EXIST_PW_HIST");
					return resultMap;
				}else if(adminInfo.getPassWd().equals(adminVO.getPassWd())){
					resultMap.put(Constants.RESULT, "EXIST_PW_HIST");
					return resultMap;
				}else{
					adminVO.setBfrPassWd(adminVO.getPassWd());
				}
				/*//OSE else 일경우 기존 비밀번호를 update 하기
				StringBuilder pwHist = new StringBuilder();
				String[] value = adminPwHist.split("\\|");
				
				if(value.length > 4) {
					pwHist.append(adminPwHist.substring(adminPwHist.indexOf("|") + 1, adminPwHist.length()));
				} else {
					pwHist.append(adminPwHist);
				}
				pwHist.append("|");
				pwHist.append(adminVO.getPassWd());
				adminVO.setBfrPassWd(pwHist.toString());*/
				
			} else {
				adminVO.setBfrPassWd(adminVO.getPassWd());
			}
			adminVO.setLoginFailCount(0);
			commonDao_oracle.update("Admin.updateAdmin",adminVO);
			resultMap.put(Constants.RESULT, "UPDATE_PW");
			
		} else {
			if(adminVO.getAccountStatus().equals("1")){ //1:활성화/2:계정잠김/3:비활성화/4:비밀번호잠김/5:마지막로그인체크무시
				adminVO.setLoginFailCount(0);
			}
			commonDao_oracle.update("Admin.updateAdmin",adminVO);
			resultMap.put(Constants.RESULT, Constants.YES);
		}
		
		
		//권한 Mapping And 권한 Change 이력 등록
	/*	System.out.println("#####################################");
		System.out.println("adminVO.getMngrId() : " + adminVO.getMngrId());
		System.out.println("adminVO.getMngrLevel() : " + adminVO.getMngrLevel());
		System.out.println("adminVO.getUpdId() : " + adminVO.getUpdId());
		System.out.println("adminVO.getOldMngrLevel() : " + adminVO.getOldMngrLevel());
		System.out.println("#####################################");*/
		
		RoleVO roleVO= new RoleVO();
		roleVO.setMngrId(adminVO.getMngrId());
		roleVO.setMngrGrpId(adminVO.getMngrLevel());
		roleVO.setUpdId(adminVO.getUpdId());
		roleVO.setUseYn(Constants.YES);
		roleVO.setOldMngrGrpId(adminVO.getOldMngrLevel());
		roleVO.setMngrChngId(UniqueKeyUtil.getUniKey());
		
		//TB_MNGR_GROUP_MPNG 테이블 update 
		commonDao_oracle.update("Role.updateAdminGroupMpng",roleVO);
		
		//TB_MNGR_GROUP_CHNG 테이블 insert 
		commonDao_oracle.insert("Role.insertAdminGroupChng",roleVO);
		
		return resultMap;
	}

	/**
	 * 운영자 정보 조회
	 * @param adminVO
	 * @return
	 */
	public AdminVO selectAdminDetail(AdminVO adminVO) throws Exception{
		
		AdminVO tempVO = commonDao_oracle.select("Admin.selectAdminDetail",adminVO);
		
		String encMngrId = AES128Cipher.AES_Encode(tempVO.getMngrId() , "abcdefghijklmnop");
		tempVO.setMngrId(encMngrId);
		
		String encMngrNm = AES128Cipher.AES_Encode(tempVO.getMngrNm() , "abcdefghijklmnop");
		tempVO.setMngrNm(encMngrNm);
		String encEmail =  AES128Cipher.AES_Encode(tempVO.getEmailAddr() , "abcdefghijklmnop");
		tempVO.setEmailAddr(encEmail);
		String encMembCtn = AES128Cipher.AES_Encode(tempVO.getClphNo() , "abcdefghijklmnop");
		tempVO.setClphNo(encMembCtn);
		
		return tempVO;
	}


	public Map<String, Object> selectAdminRoleList() throws Exception{
		RoleVO roleVO = new RoleVO();
		roleVO.setPageRowCount(9999);
		List list = commonDao_oracle.selectList("Role.roleList",roleVO);
		int totalCount = commonDao_oracle.select("Role.roleListCount");
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("list", list);
		result.put("totalCount", totalCount);
		
		return result;
		
	}


	/**
	 * 운영자 아이디 중복확인
	 * 
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> checkAdminId(AdminVO adminVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int resultCount = commonDao_oracle.select("Admin.checkAdminId",adminVO);
		
		if( resultCount > 0) {
			resultMap.put(Constants.RESULT, Constants.NO);
		} else {
			resultMap.put(Constants.RESULT, Constants.YES);
		}
		return resultMap;
	}
	
	/**
	 * 운영자 삭제 
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	public int deleteAdmin(AdminVO adminVO) throws Exception{
		return commonDao_oracle.delete("Admin.deleteAdmin",adminVO);
	}
	
	/**
	 * 운영자 맵핑 정보 삭제 
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	public int deleteAdminMpng(AdminVO adminVO) throws Exception{
		return commonDao_oracle.delete("Admin.deleteAdminMpng",adminVO);
	}
	
	/**
	 * 운영자 권한 체크
	 * 
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> checkAdminRole(AdminVO adminVO) throws Exception{
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		 adminVO = commonDao_oracle.select("Admin.checkAdminRole",adminVO);
		
		if( adminVO !=null ) {
			resultMap.put(Constants.RESULT, adminVO);
		} 
		return resultMap;
	}
	
	/**
	 * 운영자 권한 체크
	 * 
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> checkAdminRoleId(String sessionMngrId,AdminVO adminVO) throws Exception{
		String action = adminVO.getAction();
		String mngrId = adminVO.getMngrId();
		String targetId = adminVO.getUpdateTargetId();
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		 adminVO = commonDao_oracle.select("Admin.checkAdminRoleId",adminVO);
		
		
		 
		 if( adminVO !=null ) {
			resultMap.put(Constants.RESULT, Constants.YES);
			if(action.equals("INSERT")){
				resultMap.put("redirectURL", "/admin/admin/adminInsertForm.do");
			}else if(action.equals("UPDATE")){
				resultMap.put("mngrId",mngrId);
				//resultMap.put("redirectURL",mngrId);
			}
		} else {
			resultMap.put(Constants.RESULT, Constants.NO);
			
			if(action.equals("UPDATE")){
				if(!sessionMngrId.equals(targetId)){
					resultMap.put("sayMessage", "본인 이외의 사용자 조회 및 수정은 불가능 합니다.");
				}else{
					resultMap.put(Constants.RESULT, Constants.YES);
					resultMap.put("mngrId",mngrId);
				}
			}else if(action.equals("ENTRUST")){
					resultMap.put("sayMessage", "관리자 권한 위임 권한이 없습니다.");
			}else if(action.equals("DELETE")){
				resultMap.put("sayMessage", "삭제 권한이 없습니다.");
			}
			
		}
		return resultMap;
	}
	
	
	/**
	 * 임시비밀번호 이메일 전송
	 * 
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> sendTmpPassWd(AdminVO adminVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
				
		//회원 조회
		adminVO = commonDao_oracle.select("Admin.selectAdminDetail",adminVO);
		
		if( adminVO !=null ) {
			//1)비밀 번호 히스토리 추가.
			adminVO.setBfrPassWd(adminVO.getPassWd());
			//1-1)임시 비밀번호 생성
			adminVO.setNewSecrNo(TemporayPassword.temporaryPassword(10));
			adminVO.setPassWd(SecurityModule.SHA512_Encrypt(adminVO.getNewSecrNo()));
			
			//2-1)DB업데이트 성공시 이메일 발송
			int result = commonDao_oracle.update("Login.updatePwd",adminVO);
			
			boolean sendEmailResult = false;
			
			if(result > 0){
				try{
					//2)이메일 발송
					sendEmailResult = loginService.sendMail(loginService.makeEmailVO(adminVO)); 
					
				}catch(Exception e){
					logger.error("[Mngr Id]: "+ adminVO.getMngrId() +" Send Mail Exception",e);
				}
				
				if(sendEmailResult){
					//2-2)이메일 발송 성공.
					resultMap.put(Constants.RESULT, Constants.YES);
				}else{
					//2-2)이메일 발송 실패시 안내 재시도 안내 문구
					resultMap.put(Constants.RESULT, Constants.NO);
				}
			}else{
				logger.error("[Mngr Id]: "+ adminVO.getMngrId() +" New PassWord DB Upate Fail !!");
				resultMap.put(Constants.RESULT, Constants.RETRY);
			}
		} else {
			resultMap.put(Constants.RESULT, Constants.NOT_USER);
		}
		return resultMap;
	}
	
	
	/**
	 * 관리자 권한 위임
	 * 
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> entrustRoleAdmin(AdminVO adminVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		String[] mngrIdArray = adminVO.getMngrIdArray();
		
		AdminVO sourceAdmin = new AdminVO();
		sourceAdmin.setMngrId(mngrIdArray[0]);
		
		//소스 사용자
		sourceAdmin = commonDao_oracle.select("Admin.selectAdminDetail",sourceAdmin);
		//타겟 사용자
		AdminVO targetAdmin =  commonDao_oracle.select("Admin.selectAdminDetail",adminVO);
		
		
		if(sourceAdmin != null && targetAdmin != null){
			
			String sourceMngrLevel = sourceAdmin.getMngrLevel();
			String targetMngrLevel = targetAdmin.getMngrLevel();
			
			//권한 Mapping And 권한 Change 이력 등록
			/*System.out.println("#####################################");
			System.out.println("adminVO.getMngrId() : " + sourceAdmin.getMngrId());
			System.out.println("adminVO.getMngrLevel() : " + targetAdmin.getMngrLevel());
			System.out.println("adminVO.getUpdId() : " + sourceAdmin.getUpdId());
			System.out.println("adminVO.getOldMngrLevel() : " + sourceAdmin.getOldMngrLevel());
			System.out.println("sourceMngrLevel : " + sourceMngrLevel);
			System.out.println("targetAdmin : " + targetAdmin);
			System.out.println("#####################################");*/
			
			//TB_MNGR 테이블 Update
			
			RoleVO sourceRoleVO= new RoleVO();
			sourceRoleVO.setMngrId(sourceAdmin.getMngrId());
			sourceRoleVO.setMngrGrpId(targetAdmin.getMngrLevel());
			sourceRoleVO.setUpdId(adminVO.getUpdId());
			sourceRoleVO.setUseYn(Constants.YES);
			sourceRoleVO.setOldMngrGrpId(sourceAdmin.getMngrLevel());
			sourceRoleVO.setMngrChngId(UniqueKeyUtil.getUniKey());
			
			RoleVO targetRoleVO= new RoleVO();
			targetRoleVO.setMngrId(targetAdmin.getMngrId());
			targetRoleVO.setMngrGrpId(sourceAdmin.getMngrLevel());
			targetRoleVO.setUpdId(adminVO.getUpdId());
			targetRoleVO.setUseYn(Constants.YES);
			targetRoleVO.setOldMngrGrpId(targetAdmin.getMngrLevel());
			targetRoleVO.setMngrChngId(UniqueKeyUtil.getUniKey());
			
			//source
			//변경 권한 레벨 SET
			sourceAdmin.setMngrLevel(targetMngrLevel);
			commonDao_oracle.update("Admin.updateAdmin",sourceAdmin);
			//target
			//변경 권한 레벨 SET
			targetAdmin.setMngrLevel(sourceMngrLevel);
			commonDao_oracle.update("Admin.updateAdmin",targetAdmin);
			
			
			//TB_MNGR_GROUP_MPNG 테이블 update 
			commonDao_oracle.update("Role.updateAdminGroupMpng",sourceRoleVO);
			
			//TB_MNGR_GROUP_CHNG 테이블 insert 
			commonDao_oracle.insert("Role.insertAdminGroupChng",sourceRoleVO);

			//TB_MNGR_GROUP_MPNG 테이블 update 
			commonDao_oracle.update("Role.updateAdminGroupMpng",targetRoleVO);
			
			//TB_MNGR_GROUP_CHNG 테이블 insert 
			commonDao_oracle.insert("Role.insertAdminGroupChng",targetRoleVO);
			
			resultMap.put(Constants.RESULT, Constants.YES);
		}else{
			resultMap.put(Constants.RESULT, Constants.NOT_USER);
		}
		
		return resultMap;
	}
	
	
	
	/**
	 * 운영자 패스워드 인증
	 * 
	 * @param adminVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> checkAdminPwd(AdminVO adminVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if(StringUtils.isNotEmpty(adminVO.getPassWd())) {
			//웹에서 암호화 한 비밀번호 복호화
			String decPw = AES128Cipher.AES_Decode(adminVO.getPassWd(), "abcdefghijklmnop");
			
			//LGU에서 제공받은 암화 모듈로 암화화 진행
			adminVO.setPassWd(SecurityModule.SHA512_Encrypt(decPw));
		}
		
		//Admin 회원 조회
		AdminVO	 resultLogin = commonDao_oracle.select("Login.checkAdminPwd",adminVO);
	
		if(resultLogin != null) {
			//ID, PW 일치함
			if(resultLogin.getPassWd().equals(adminVO.getPassWd())) {
				resultMap.put(Constants.RESULT, Constants.YES);
				//resultMap.put("redirectURL" , "/admin/admin/adminUpdateForm.do?mngrId="+adminVO.getUpdateTargetId());
				resultMap.put("redirectURL" , "/admin/admin/adminUpdateForm.do");
				resultMap.put("id" , adminVO.getMngrId());
				resultMap.put("pwd" , adminVO.getPassWd());
			}else{
				resultMap.put(Constants.RESULT, Constants.NO);
			}
		}else{
			resultMap.put(Constants.RESULT, Constants.NO);
		}
		return resultMap;
	}
	
	
	//PAGE
	@Override
	public List<AdminVO> selectAdminPageList(AdminPagingVO adminPagingVO){
		 List<AdminVO> resultList = commonDao_oracle.selectPagedList("Admin.selectAdminList", adminPagingVO);
		 return resultList;
	}
	
	
	public static String userInfoMasking(String str,String type) {
		String resultStr = "";
		if(type.endsWith("name")){
			for(int idx=0; idx<str.length(); idx++){
				if(idx == 0 || idx == str.length() -1){
					resultStr += str.substring(idx,idx+1); 
				}else{
					
					resultStr += "*"; 
				}
			}
		}else if(type.endsWith("ctn")){
			String Fhp, Mhp, Bhp = "";

			if (str == null || "".equals(str))
				return "";
			
			if(isStringDouble(str)){  // 핸드폰 번호 인경우
				str = str.replace("-", ""); // 문자열에 -(하이픈)있으면 제거

				if (str.length() < 10 || str.length() > 11) {
					return "***";
				} else {
					str = str.replace("-", "");
					Fhp = (str.trim()).substring(0, 3);
					//Mhp = (str.trim()).substring(3, str.length() - 4);
					Bhp = (str.trim()).substring(str.length() - 4, str.length());
					resultStr =  Fhp.trim() + "****" + "" + Bhp.trim();
				}
			}else{ // id 인경우
				//Noting
				resultStr = str;
			}
			
		}else if(type.endsWith("email")){
			
			String[] emailArr = str.split("@");
			
			resultStr = emailArr[0].replaceAll("(?<=.{3}).", "*") + "@" +emailArr[1];
			
		}else{
			//nothing
		}
		
		return resultStr;
	}
	
	/**
	 * 8자리 이상 특수문자 사용
	 * 
	 * @param passWd
	 * @return
	 */
	public static boolean validationPwd(String passWd){
		Pattern p = Pattern.compile("([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])");
		
		Matcher m = p.matcher(passWd);
		if (m.find()){
		   if(passWd.length() > 8 ){
			   return true;
		   }
		}
		return false;
	}
	
	/**
	 * 
	 * Password 내의 CTN 포함 여부
	 * @param ctn
	 * @param pwd
	 * @return
	 */
	public static boolean idIncludCtn (String ctn,String pwd){
		if(pwd.indexOf(ctn) > -1){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 * 
	 * Password 내의 ID 포함 여부
	 * @param id
	 * @param pwd
	 * @return
	 */
	public static boolean idIncludCheck (String id,String pwd){
		if(pwd.indexOf(id) > -1){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 * 
	 * @param d
	 * @return
	 */
	public static boolean checkDuplicate3Character(String d) {
		int p = d.length();
		byte[] b = d.getBytes();
		for (int i = 0; i < ((p * 2) / 3); i++) {
			int b1 = b[i + 1];
			int b2 = b[i + 2];
 
			if ((b[i] == b1) && (b[i] == b2)) {
				return true;
			} else {
				continue;
			}
		}
		return false;
	}
	
	/**
	 * e-mail Validaion Check
	 * @param email
	 * @return
	 */
	public static boolean emailValidationCheck (String email){
		Pattern p = Pattern.compile("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
		Matcher m = p.matcher(email);
		if (m.find()){
		  return true;
		}
		return false;

	}
	
	/**
	 * 3자리 이상의 연속 문자 사용 여부
	 * @param d
	 * @return
	 */
	public static boolean checkContinuous3Character(String d) {
		byte[] b = d.getBytes();
		int p = d.length();

		// 연속된 3개의 문자 사용불가 (오름차순)
		for (int i = 0; i < ((p * 2) / 3); i++) {
			int b1 = b[i] + 1;
			int b2 = b[i + 1];
			int b3 = b[i + 1] + 1;
			int b4 = b[i + 2];

			if ((b1 == b2) && (b3 == b4)) {
				return true;
			} else {
				continue;
			}
		}
		// 연속된 3개의 문자 사용불가 (내림차순)
		for (int i = 0; i < ((p * 2) / 3); i++) {
			int b1 = b[i + 1] + 1;
			int b2 = b[i + 2] + 2;

			if ((b[i] == b1) && (b[i] == b2)) {
				return true;
			} else {
				continue;
			}
		}
		return false;
	}
	
	/**
	 * IP 유효성 Check
	 * @param ip
	 * @return
	 */
	
	public static boolean ipValidationCheck (String ip){
		Pattern p = Pattern.compile("^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$");
		Matcher m = p.matcher(ip);
		if (m.find()){
		  return true;
		}
		return false;

	}
	
	public static boolean isStringDouble(String s) {
		try {
			Double.parseDouble(s);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}


}
