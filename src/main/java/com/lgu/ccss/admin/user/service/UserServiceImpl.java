package com.lgu.ccss.admin.user.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.lgu.ccss.admin.admin.domain.AdminVO;
import com.lgu.ccss.admin.admin.service.AdminServiceImpl;
import com.lgu.ccss.admin.user.domain.CommAgrVO;
import com.lgu.ccss.admin.user.domain.UserVO;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.domain.Constants.ResultCode;
import com.lgu.ccss.common.utility.AES128Cipher;
import com.lgu.ccss.common.utility.SessionUtil;
import com.lgu.ccss.common.utility.excel.ExcelRead;
import com.lgu.ccss.common.utility.excel.ExcelReadOption;

import devonframe.dataaccess.CommonDao;

@Service("userService")
public class UserServiceImpl implements UserService {
	
	private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

    @Resource(name = "commonDao_oracle")
    private CommonDao commonDao_oracle;
    
    @Resource(name = "commonDao_altibase")
    private CommonDao commonDao_altibase;
    
    @Autowired
    private AdminServiceImpl adminServiceImpl;
    
    @Value("#{config['excel.upload.path']}")
	private String EXCEL_UPLOAD_PATH;
	
	@Value("#{config['excel.download.path']}")
	private String EXCEL_DOWNLOAD_PATH;
	
	@Value("#{config['excel.form.download.path']}")
	private String EXCEL_FORM_DOWNLOAD_PATH;
	
	@Value("#{config['excel.form.download.file.name']}")
	private String EXCEL_FORM_DOWNLOAD_FILE_NAME;
	
	/**
	 * 사용자 리스트 카운트
	 * @param adminVO
	 * @return
	 */
	public int selectUserListCnt(UserVO userVO) throws Exception{
	    return commonDao_oracle.select("User.selectUserListCnt",userVO);
	}


	/**
	 * 사용자 리스트 조회
	 * @param adminVO
	 * @return
	 */
	public Map<String, Object> selectUserList(UserVO userVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<UserVO> resultList = commonDao_oracle.selectList("User.selectUserList",userVO);
		
		
		int totalCount = commonDao_oracle.select("User.selectUserListCnt",userVO);
		
		for(UserVO tempVO : resultList) {
			String membCtn = tempVO.getDeviceCtn();
			
			tempVO.setDeviceCtn(AdminServiceImpl.userInfoMasking(membCtn,"ctn"));
		}
		
		//2개발 범위
		/*for(int idx=0; idx < resultList.size(); idx++){

			String deviceCtn = resultList.get(idx).getDeviceCtn();
			String connDeviceId = resultList.get(idx).getDeviceModelId();
			
			
			UserVO tempVO = new UserVO();
			tempVO.setDeviceCtn(deviceCtn);
			tempVO.setConnDeviceId(connDeviceId);
			
			resultList.get(idx).setDeviceCtn(adminServiceImpl.userInfoMasking(deviceCtn, "ctn"));
			
			int cnt = commonDao_altibase.select("User.checkUserpushConnect",tempVO);
			
			if( cnt > 0){
				
				resultList.get(idx).setPushConnectionYn(Constants.YES);
			}
		}*/		
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);
		return resultMap;
	}
	
	
	/**
	 * 사용자 리스트 조회 Excel
	 * @param adminVO
	 * @return
	 */
	public Map<String, Object> selectUserListExcel(UserVO userVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<UserVO> resultList = commonDao_oracle.selectList("User.selectUserListExcel",userVO);
		int totalCount = commonDao_oracle.select("User.selectUserListCnt",userVO);
		
		

		
	
		/*for(int idx=0; idx < resultList.size(); idx++){
			
			
			String deviceCtn = resultList.get(idx).getDeviceCtn();
			String connDeviceId = resultList.get(idx).getDeviceModelId();
			
			UserVO tempVO = new UserVO();
			tempVO.setDeviceCtn(deviceCtn);
			tempVO.setConnDeviceId(connDeviceId);
			
			resultList.get(idx).setDeviceCtn(adminServiceImpl.userInfoMasking(deviceCtn, "ctn"));
			
			int cnt = commonDao_altibase.select("User.checkUserpushConnect",tempVO);
			
			if( cnt > 0){
				resultList.get(idx).setPushConnectionYn(Constants.YES);
			}
		}*/
		
		
		
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);
		
		//리스트 검색 조건.
		if(String.valueOf(userVO.getStartDate()) !=null && !String.valueOf(userVO.getStartDate()).equals("")){
			resultMap.put("startDate", String.valueOf(userVO.getStartDate()));
		}
		
		if(String.valueOf(userVO.getEndDate()) !=null && !String.valueOf(userVO.getEndDate()).equals("")){
			resultMap.put("endDate", String.valueOf(userVO.getEndDate()));
		}
		
		if(String.valueOf(userVO.getDeviceCtn()) !=null && !String.valueOf(userVO.getDeviceCtn()).equals("")){
			resultMap.put("deviceCtn", String.valueOf(userVO.getDeviceCtn()));
		}
		
		if(String.valueOf(userVO.getProductNm()) !=null && !String.valueOf(userVO.getProductNm()).equals("")){
			resultMap.put("productNm", String.valueOf(userVO.getProductNm()));
		}
		
		if(String.valueOf(userVO.getNewRejoinYn()) !=null && !String.valueOf(userVO.getNewRejoinYn()).equals("")){
			resultMap.put("newRejoinYn", String.valueOf(userVO.getNewRejoinYn()));
		}
		
		if(String.valueOf(userVO.getUseStatus()) !=null && !String.valueOf(userVO.getUseStatus()).equals("")){
			resultMap.put("useStatus", String.valueOf(userVO.getUseStatus()));
		}
		
		if(String.valueOf(userVO.getMembId()) !=null && !String.valueOf(userVO.getMembId()).equals("")){
			resultMap.put("membId", String.valueOf(userVO.getMembId()));
		}
		
		if(String.valueOf(userVO.getMembNo()) !=null && !String.valueOf(userVO.getMembNo()).equals("")){
			resultMap.put("membNo", String.valueOf(userVO.getMembNo()));
		}
		
		if(String.valueOf(userVO.getFeeType()) !=null && !String.valueOf(userVO.getFeeType()).equals("")){
			resultMap.put("feeType", String.valueOf(userVO.getFeeType()));
		}
		
		
		/*if(String.valueOf(userVO.getPushConnectionYn()) !=null && !String.valueOf(userVO.getPushConnectionYn()).equals("")){
			resultMap.put("pushConnectionYn", String.valueOf(userVO.getPushConnectionYn()));
		}*/
		return resultMap;
	}
	
	
	
	public Map<String, Object> selectDetailUserInfo(UserVO userVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		userVO = commonDao_oracle.select("User.selectDetailUserInfo",userVO);
		
		String membCtn = userVO.getDeviceCtn();
		
		System.out.println("-----------------------------------------------------------");
		System.out.println("membCtn : "+ membCtn);
		System.out.println("-----------------------------------------------------------");
		if(membCtn !=null && membCtn.length() > 0){
			
			membCtn = AES128Cipher.AES_Encode(membCtn , "abcdefghijklmnop");
		}
		
		userVO.setMembCtn(membCtn);
		userVO.setTransToken("");
		resultMap.put("userVO", commonDao_oracle.select("User.selectDetailUserInfo",userVO));
		return resultMap;
	}
	
	/*##################################################################################################
											데이터 약관 동의 관리
	##################################################################################################*/
	
	/**
	 * 데이터 약관 정보 리스트 조회
	 * 
	 * @param commAgrVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectcommAgrList(CommAgrVO commAgrVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> resultList = commonDao_oracle.selectList("User.selectcommAgrList",commAgrVO);
		
		int totalCount = commonDao_oracle.select("User.selectcommAgrListCnt",commAgrVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);
		
		return resultMap;
	}
	/**
	 * 데이터 약관 정보 삭제
	 * 
	 * @param commAgrVO
	 * @return
	 * @throws Exception
	 */
	
	public Map<String, Object> deleteCommAgr(CommAgrVO commAgrVO)  throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int deleteCnt = commonDao_oracle.delete("User.deleteCommAgr",commAgrVO);
		
		if(deleteCnt > 0){
			resultMap.put("resultCode", ResultCode.RESULT_CODE_0000.getCode());
		}else{
			resultMap.put("resultCode", ResultCode.RESULT_CODE_4000.getCode());
		}
		
		return resultMap;
	}

	
	/**
	 * 신규 데이터 약관 정보 등록
	 * @param commAgrVO
	 * @return
	 */
	public Map<String, Object> insertCommAgr(CommAgrVO commAgrVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int checkCount = 0;
		
		checkCount =commonDao_oracle.select("User.checkExistCommAgr",commAgrVO);
		
		
		if(checkCount > 0) {
			resultMap.put(Constants.RESULT, Constants.EXIST);
		}else{
			commonDao_oracle.insert("User.insertCommAgr",commAgrVO);
			resultMap.put(Constants.RESULT, Constants.YES);
		}
		return resultMap;
	}
	
	
	/**
	 * 데이터 약관 정보 상세
	 * 
	 * @param commAgrVO
	 * @return
	 * @throws Exception
	 */
	public CommAgrVO selectcommAgrDetail(CommAgrVO commAgrVO) throws Exception {
		commAgrVO = commonDao_oracle.select("User.selectcommAgrDetail",commAgrVO);
		
		return commAgrVO; 
	}

	
	/**
	 * 데이터 약관 정보 수정
	 * 
	 * @param commAgrVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> updateCommAgr(CommAgrVO commAgrVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		/*int checkCount = 0;
		
		checkCount =commonDao_oracle.select("User.checkExistCommAgr",commAgrVO);
		
		if(checkCount > 0) {
			
			resultMap.put(Constants.RESULT, Constants.EXIST);
			
		}else{
			int resultCount = commonDao_oracle.update("User.updateCommAgr",commAgrVO);
			
			if( resultCount> 0) {
				
				resultMap.put(Constants.RESULT, Constants.YES);
				
			}else{
				
				resultMap.put(Constants.RESULT, Constants.NO);
			}
		}*/
		
		int resultCount = commonDao_oracle.update("User.updateCommAgr",commAgrVO);
		
		if( resultCount> 0) {
			
			resultMap.put(Constants.RESULT, Constants.YES);
			
		}else{
			
			resultMap.put(Constants.RESULT, Constants.NO);
		}
		
		return resultMap;
	}
	
	
	/*
	 *commAgr 엑셀 업로드 
	 *  DEVICE_CTN |UICCID|TERMS_NO|TERMS_AUTH_NO|AGR_YN |VALID_START_DT|VALID_END_DT|ITEM_SN|USIM_MODEL_NM|NAVI_SN
	 */
	@Override
	@Transactional
	public Map<String, Object> excelUpload(File destFile ,String regId) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
	
		ExcelReadOption excelReadOption = new ExcelReadOption();
		excelReadOption.setFilePath(destFile.getAbsolutePath());
		excelReadOption.setOutputColumns("A","B","C","D","E","F","G","H","I","J"); 
		//DEVICE_CTN |UICCID|TERMS_NO|TERMS_AUTH_NO|AGR_YN |VALID_START_DT|VALID_END_DT|ITEM_SN|USIM_MODEL_NM|NAVI_SN
		excelReadOption.setStartRow(2);//ROW 시작 위치

		List<Map<String, String>>excelContent =ExcelRead.read(excelReadOption);
		logger.debug("excelContent:" + excelContent);

		//DB Duplication 리스트 체크
		boolean checkUsedCtnUiccidFlag =false;
		for(int idx = 0; idx < excelContent.size(); idx ++){

			String deviceCtn = excelContent.get(idx).get("A");
			String uiccid = excelContent.get(idx).get("B");
			
			CommAgrVO tmpCommAgrVO = new CommAgrVO();
			tmpCommAgrVO.setDeviceCtn(deviceCtn);
			tmpCommAgrVO.setUiccid(uiccid);

			int resultCount = commonDao_oracle.select("User.checkExistCommAgr",tmpCommAgrVO);
			if (resultCount > 0) {
				checkUsedCtnUiccidFlag = true;
				resultMap.put(Constants.RESULT, Constants.DUPLICATE);
				resultMap.put("deviceCtn", deviceCtn);
				resultMap.put("uiccId", uiccid);
				return resultMap;
			}
		}
		
		boolean processSucFlag= false;
		
		// TB_MEMB_COMM_AGR 리스트 체크
		if (!checkUsedCtnUiccidFlag) {
			for (int idx = 0; idx < excelContent.size(); idx++) {
				CommAgrVO insertCmmAgrVO = new CommAgrVO();
				insertCmmAgrVO.setRegId(regId);
				insertCmmAgrVO.setUpdId(regId);
				insertCmmAgrVO.setDeviceCtn(excelContent.get(idx).get("A"));
				insertCmmAgrVO.setUiccid(excelContent.get(idx).get("B"));
				insertCmmAgrVO.setTermsNo(excelContent.get(idx).get("C"));
				insertCmmAgrVO.setTermsAuthNo(excelContent.get(idx).get("D"));
				insertCmmAgrVO.setAgrYn(excelContent.get(idx).get("E"));
				insertCmmAgrVO.setValidStartDt(excelContent.get(idx).get("F").replaceAll("-", ""));
				insertCmmAgrVO.setValidEndDt(excelContent.get(idx).get("G").replaceAll("-", ""));
				insertCmmAgrVO.setItemSn(excelContent.get(idx).get("H"));
				insertCmmAgrVO.setUsimModelNm(excelContent.get(idx).get("I"));
				insertCmmAgrVO.setNaviSn(excelContent.get(idx).get("J"));
				logger.debug("insertCmmAgrVO:" + insertCmmAgrVO.toString());
				
				commonDao_oracle.insert("User.insertCommAgr",insertCmmAgrVO);
			}
			processSucFlag = true;
		}
		
		if(processSucFlag){
			resultMap.put(Constants.RESULT, Constants.YES);
		}else{
			resultMap.put(Constants.RESULT, Constants.NO);
		}
		
		destFile.delete();
		
		return resultMap;
	}
	
}
