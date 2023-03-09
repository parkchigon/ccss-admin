package com.lgu.ccss.admin.system.code.service;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.feelingk.UniqueKeyUtil;
import com.lgu.ccss.admin.admin.domain.AdminPagingVO;
import com.lgu.ccss.admin.admin.domain.AdminVO;
import com.lgu.ccss.admin.app.domain.AppVO;
import com.lgu.ccss.admin.product.domain.ProductVO;
import com.lgu.ccss.admin.system.code.domain.CodeVO;
import com.lgu.ccss.admin.system.code.domain.ServiceStatCodeVO;
import com.lgu.ccss.admin.system.role.domain.RoleVO;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.domain.Constants.ResultCode;
import com.lgu.ccss.common.utility.AES128Cipher;

import devonframe.dataaccess.CommonDao;
import lguplus.security.vulner.SecurityModule;

@Service("codeService")
public class CodeServiceImpl implements CodeService {
	

	@Resource(name = "commonDao_oracle")
	private CommonDao commonDao_oracle;

	
	/**
	 * GRP_CD_ID 조회
	 * @param codeVO
	 * @return String
	 */
	
	public String selectGrpCdId (String grpCdNm) throws Exception{
		return  commonDao_oracle.select("Code.selectGrpCdId",grpCdNm);
	}
	
	
	/**
	 * Group Code 정보 리스트 조회
	 * 
	 * @param appVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectGroupCodeList(CodeVO codeVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> resultList = commonDao_oracle.selectList("Code.selectGroupCodeList",codeVO);
		int totalCount = commonDao_oracle.select("Code.selectGroupCodeListCnt",codeVO);
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);
		return resultMap;
		
	}
		
	
	/**
	 * Group Code 정보 삭제
	 * 
	 * @param codeVO
	 * @return
	 * @throws Exception
	 */
	
	public Map<String, Object> deleteGroupCode(CodeVO codeVO)  throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int deleteCnt = commonDao_oracle.delete("Code.deleteGroupCode",codeVO);
		
		if(deleteCnt > 0){
			resultMap.put("resultCode", ResultCode.RESULT_CODE_0000.getCode());
			
			commonDao_oracle.delete("Code.deleteDtlCodeByGrpCdArr",codeVO);
		}else{
			resultMap.put("resultCode", ResultCode.RESULT_CODE_4000.getCode());
		}
		
		return resultMap;
	}
	
	/**
	 * DTL Code 정보 삭제
	 * 
	 * @param codeVO
	 * @return
	 * @throws Exception
	 */
	
	public Map<String, Object> deleteDtlCode(CodeVO codeVO)  throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int deleteCnt = commonDao_oracle.delete("Code.deleteDtlCode",codeVO);
		
		if(deleteCnt > 0){
			resultMap.put("resultCode", ResultCode.RESULT_CODE_0000.getCode());
		}else{
			resultMap.put("resultCode", ResultCode.RESULT_CODE_4000.getCode());
		}
		
		return resultMap;
	}
	
	
	/**
	 * 신규 Group Code 정보 등록
	 * @param codeVO
	 * @return
	 */
	public Map<String, Object> insertNewGroupCode(CodeVO codeVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		codeVO.setGrpCdId(UniqueKeyUtil.getUniKey());
		int checkCount = 0;
		//해당 grpCdN으로 이 있는지 검색
		checkCount =commonDao_oracle.select("Code.checkExistGroupCode",codeVO);
		
		if(checkCount > 0) {
			resultMap.put(Constants.RESULT, Constants.EXIST);
		}else{
			commonDao_oracle.insert("Code.insertNewGroupCode",codeVO);
			resultMap.put(Constants.RESULT, Constants.YES);
		}
		return resultMap;
	}
	
	
	/**
	 * 신규 Dtl Code 정보 등록
	 * @param codeVO
	 * @return
	 */
	public Map<String, Object> insertNewDtlCode(CodeVO codeVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		codeVO.setDtlCdId(UniqueKeyUtil.getUniKey());
		int checkCountCodeNm = 0;
		int checkCountCodeVal = 0;
		//해당 grpCdId, dtlCdNm , cvVal로 이 있는지 검색
		checkCountCodeNm =commonDao_oracle.select("Code.checkExistDtlCodeNm",codeVO);
		//해당 grpCdId,  cvVal로 이 있는지 검색
		checkCountCodeVal =commonDao_oracle.select("Code.checkExistDtlCodeVal",codeVO);
		
		if(checkCountCodeNm > 0 || checkCountCodeVal > 0 ) {
			resultMap.put(Constants.RESULT, Constants.EXIST);
		}else{
			commonDao_oracle.insert("Code.insertNewDtlCode",codeVO);
			resultMap.put(Constants.RESULT, Constants.YES);
		}
		return resultMap;
	}
	
	
	/**
	 * Group Code 정보 상세
	 * 
	 * @param codeVO
	 * @return
	 * @throws Exception
	 */
	public CodeVO selectGroupCodeDetail(CodeVO codeVO) throws Exception {
		codeVO = commonDao_oracle.select("Code.selectGroupCodeDetail",codeVO);
		return codeVO; 
	}

	/**
	 * Dtl Code 정보 상세
	 * 
	 * @param codeVO
	 * @return
	 * @throws Exception
	 */
	public  CodeVO selectDtlCodeDetail(CodeVO codeVO) throws Exception {
		
		codeVO = commonDao_oracle.select("Code.selectDtlCodeDetail",codeVO);
		return codeVO; 
	}
	/**
	 * Group Code 정보 수정
	 * 
	 * @param codeVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> updateGroupCode(CodeVO codeVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int checkCount = 0;

		checkCount =commonDao_oracle.select("Code.checkExistGroupCode",codeVO);
	
		if(checkCount > 0) {
			
			resultMap.put(Constants.RESULT, Constants.EXIST);
			
		}else{
			int resultCount = commonDao_oracle.update("Code.updateGroupCode",codeVO);
			
			if( resultCount> 0) {
				
				resultMap.put(Constants.RESULT, Constants.YES);
				
			}else{
				
				resultMap.put(Constants.RESULT, Constants.NO);
			}
		}
		
		return resultMap;
	}
	
	
	/**
	 * DTL Code 정보 수정
	 * 
	 * @param codeVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> updateDtlCode(CodeVO codeVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		//int checkCount = 0;
		//checkCount =commonDao_oracle.select("Code.checkExistDtlCode",codeVO);
		
		int checkCountCodeNm = 0;
		int checkCountCodeVal = 0;
		//해당 grpCdId, dtlCdNm , cvVal로 이 있는지 검색
		checkCountCodeNm =commonDao_oracle.select("Code.checkExistDtlCodeNm",codeVO);
		//해당 grpCdId,  cvVal로 이 있는지 검색
		checkCountCodeVal =commonDao_oracle.select("Code.checkExistDtlCodeVal",codeVO);
		
		if(checkCountCodeNm > 0 || checkCountCodeVal > 0) {
			
			resultMap.put(Constants.RESULT, Constants.EXIST);
			
		}else{
			int resultCount = commonDao_oracle.update("Code.updateDtlCode",codeVO);
			
			if( resultCount> 0) {
				
				resultMap.put(Constants.RESULT, Constants.YES);
				
			}else{
				
				resultMap.put(Constants.RESULT, Constants.NO);
			}
		}
		
		return resultMap;
	}
	
	
	/**
	 * DTL_CODE 조회
	 * @param codeVO
	 * @return
	 */
	public Map<String, Object> selectDtlCodeList(CodeVO codeVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<CodeVO> resultList = commonDao_oracle.selectList("Code.selectDtlCodeList",codeVO);

		int totalCount = commonDao_oracle.select("Code.selectDtlCodeListCnt",codeVO);
	
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);
		return resultMap;
	}
	
	
	/**
	 * DTL_CODE 조회
	 * @param codeVO
	 * @return
	 */
	public Map<String, Object> selectDtlCodeListPaging(CodeVO codeVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<CodeVO> resultList = commonDao_oracle.selectList("Code.selectDtlCodeListPaging",codeVO);

		int totalCount = commonDao_oracle.select("Code.selectDtlCodeListCnt",codeVO);
	
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);
		return resultMap;
	}
	
	
	/**
	  DTL_CODE 조회
	  @param codeVO
	  @return
	 */
	public Map<String, Object> selectDtlCodeListByGrpCodeNm(CodeVO codeVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<CodeVO> resultList = commonDao_oracle.selectList("Code.selectDtlCodeListByGrpCodeNm",codeVO);
		resultMap.put("resultList", resultList);
		return resultMap;
	}
	
	
	/*
	*//**
	 * Service Stat DTL_CODE 조회
	 * @param codeVO
	 * @return
	 *//*
	public Map<String, Object> selectServiceStatDtlCodeList(HashMap<String,Object> hashmap) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<CodeVO> resultList = commonDao_oracle.selectList("Code.selectServiceStatDtlCodeList",hashmap);

		int totalCount = commonDao_oracle.select("Code.selectServiceStatDtlCodeListCnt",hashmap);
	
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);
		return resultMap;
	}
	*/
	
	/**
	 * 서비스 통계 DTL_CODE 조회
	 * @param codeVO
	 * @return
	 */
	public Map<String, Object> selectServiceStatDtlCodeList(ServiceStatCodeVO serviceStatCodeVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<ServiceStatCodeVO> resultList = commonDao_oracle.selectList("Code.selectServiceStatDtlCodeList",serviceStatCodeVO);

		int totalCount = commonDao_oracle.select("Code.selectServiceStatDtlCodeListCnt",serviceStatCodeVO);
	
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);
		return resultMap;
	}
}
