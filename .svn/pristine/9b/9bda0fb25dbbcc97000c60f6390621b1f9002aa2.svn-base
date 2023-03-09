package com.lgu.ccss.admin.system.code.service;

import java.util.HashMap;
import java.util.Map;

import com.lgu.ccss.admin.system.code.domain.CodeVO;
import com.lgu.ccss.admin.system.code.domain.ServiceStatCodeVO;

public interface CodeService {

	public String selectGrpCdId (String grpCdNm) throws Exception;
	
	public Map<String, Object> selectGroupCodeList(CodeVO codeVO) throws Exception;
	
	public Map<String, Object> selectDtlCodeList(CodeVO codeVO) throws Exception;
	
	//public Map<String, Object> selectDtlCodeListByGcodeNm(CodeVO codeVO) throws Exception;
	
	public Map<String, Object> selectDtlCodeListByGrpCodeNm(CodeVO codeVO) throws Exception;
	
	public Map<String, Object> insertNewGroupCode(CodeVO codeVO) throws Exception;
	
	public Map<String, Object> insertNewDtlCode(CodeVO codeVO) throws Exception;

	public CodeVO selectGroupCodeDetail(CodeVO codeVO) throws Exception ;
	
	public CodeVO selectDtlCodeDetail(CodeVO codeVO) throws Exception ;

	public Map<String, Object> updateGroupCode(CodeVO codeVO) throws Exception;
	
	public Map<String, Object> updateDtlCode(CodeVO codeVO) throws Exception;
	
	public Map<String, Object> deleteGroupCode(CodeVO codeVO)  throws Exception;
	
	public Map<String, Object> deleteDtlCode(CodeVO codeVO)  throws Exception;
	
	//public Map<String, Object> selectServiceStatDtlCodeList(HashMap<String,Object> hashmap) throws Exception;
	
	public Map<String, Object> selectServiceStatDtlCodeList(ServiceStatCodeVO serviceStatCodeVO) throws Exception;

}
