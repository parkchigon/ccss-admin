package com.lgu.ccss.admin.voice.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.feelingk.UniqueKeyUtil;
import com.lgu.ccss.admin.system.menu.service.MenuServiceImpl;
import com.lgu.ccss.admin.term.domain.TermsVO;
import com.lgu.ccss.admin.voice.domain.VoiceVO;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.domain.Constants.ResultCode;

import devonframe.dataaccess.CommonDao;

@Service("voiceService")
public class VoiceServiceImpl implements VoiceService {
    
	private static final Logger logger = LoggerFactory.getLogger(VoiceServiceImpl.class);
	
	@Resource(name = "commonDao_oracle")
	 private CommonDao commonDao_oracle;
	
	/**
	 * 도메인 리스트 조회(Paging)
	 * 
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectDomainList(VoiceVO voiceVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> pagingResultList = commonDao_oracle.selectList("Voice.selectDomainList",voiceVO);
		
		List<Map<String, Object>> resultAllList = commonDao_oracle.selectList("Voice.selectAllDomainList",voiceVO);
		
		int totalRatio = 0;
		
		for(int idx=0; idx < resultAllList.size(); idx++){
			VoiceVO  temp = (VoiceVO) resultAllList.get(idx);
			totalRatio+= Integer.parseInt(temp.getExposureRatio());
		}
		
		int totalCount = commonDao_oracle.select("Voice.selectDomainListCnt",voiceVO);
		
		resultMap.put("resultList", pagingResultList);
		resultMap.put("totalCount", totalCount);
		resultMap.put("totalRatio",totalRatio);
		return resultMap;
	}
	
	
	/**
	 * 도메인 리스트 조회(전체)
	 * 
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectAllDomainList(VoiceVO voiceVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, Object>> resultlList = commonDao_oracle.selectList("Voice.selectAllDomainList",voiceVO);
		resultMap.put("resultList", resultlList);
		return resultMap;
	}
	
	/**
	 * 도메인 상세 조회
	 * 
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectDomainAjax(VoiceVO voiceVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		voiceVO = commonDao_oracle.select("Voice.selectDomainAjax",voiceVO);
		resultMap.put("voiceVO", voiceVO);
		return resultMap;
	}
	
	
	/**
	 * 도메인 등록
	 * 
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> addDomainAjax(VoiceVO voiceVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		voiceVO.setVoiceDomainNo(UniqueKeyUtil.getUniKey());
		
		int exposureRatio = Integer.parseInt(voiceVO.getExposureRatio());
		
		if(exposureRatio > 0){
			//해당 도메인 있는지 체크
			boolean exist = checkDomain(voiceVO);
			
			if(!exist){
				//Ratio Cheak
				int addDomainRatio = Integer.parseInt(voiceVO.getExposureRatio());
				
				//노출 카운트 
				List<Map<String, Object>> resultList = commonDao_oracle.selectList("Voice.selectAllDomainList",voiceVO);
				int dbDatatotalRatio = 0;
				
				for(int idx=0; idx < resultList.size(); idx++){
					VoiceVO  temp = (VoiceVO) resultList.get(idx);
					dbDatatotalRatio+= Integer.parseInt(temp.getExposureRatio());
				}
				
				if(addDomainRatio + dbDatatotalRatio > 100){
					logger.error("Domain exposureRatio Over : " + addDomainRatio + dbDatatotalRatio);
					resultMap.put(Constants.RESULT, Constants.OVER);
				}else{
					commonDao_oracle.insert("Voice.insertDomain",voiceVO);
					resultMap.put(Constants.RESULT, Constants.YES);
				}
				
			}else{
				resultMap.put(Constants.RESULT, Constants.EXIST);
			}
		}else{
			resultMap.put(Constants.RESULT, Constants.FAIL);
		}
		
		return resultMap;
	}
	
	
	/**
	 * 도메인 체크
	 * 
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	public boolean checkDomain(VoiceVO voiceVO){
		boolean result = false;
		int cnt = commonDao_oracle.select("Voice.checkDomain",voiceVO);
		
		if(cnt > 0){
			result = true;
		}
		return result;
	}
	
	/**
	 * 도메인 삭제
	 * 
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	
	public Map<String, Object> deleteDomainAjax(VoiceVO voiceVO)  throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int deleteCnt = commonDao_oracle.delete("Voice.deleteDomainAjax",voiceVO);
		
		if(deleteCnt > 0){
			resultMap.put("resultCode", ResultCode.RESULT_CODE_0000.getCode());
		}else{
			resultMap.put("resultCode", ResultCode.RESULT_CODE_4000.getCode());
		}
		
		return resultMap;
	}
	
	/**
	 * 도메인 수정
	 * 
	 * @param termsVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> editDomainAjax(VoiceVO voiceVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int exposureRatio = Integer.parseInt(voiceVO.getExposureRatio());
		
		if(exposureRatio > 0){
			//Ratio Cheak
			int editDomainRatio = Integer.parseInt(voiceVO.getExposureRatio());
			
			List<Map<String, Object>> resultList = commonDao_oracle.selectList("Voice.selectAllDomainList",voiceVO);
			int dbDatatotalRatio = 0;
			
			for(int idx=0; idx < resultList.size(); idx++){
				VoiceVO  temp = (VoiceVO) resultList.get(idx);
				dbDatatotalRatio+= Integer.parseInt(temp.getExposureRatio());
			}
				
			if(editDomainRatio + dbDatatotalRatio > 100){ // 노출빈도 초과
				logger.error("Domain exposureRatio Over : " + editDomainRatio + dbDatatotalRatio);
				resultMap.put(Constants.RESULT, Constants.OVER);
			}else{
				
				//업데이트
				if(commonDao_oracle.update("Voice.updateDomain",voiceVO) > 0){
					resultMap.put(Constants.RESULT, Constants.YES);
				}else{
					resultMap.put(Constants.RESULT, Constants.NO);
				}
				
			}	
		}else{
			resultMap.put(Constants.RESULT, Constants.FAIL);
		}

		return resultMap;
	}
	
	
	
	/**
	 * 음성가이드 버전 리스트 조회
	 * 
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectVersionList(VoiceVO voiceVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> resultList = commonDao_oracle.selectList("Voice.selectVersionList",voiceVO);
		VoiceVO currentVO = commonDao_oracle.select("Voice.currentSelectVersion",voiceVO);
		
		
		int totalCount = commonDao_oracle.select("Voice.selectVersionListCnt",voiceVO);
		resultMap.put("resultList", resultList);
		resultMap.put("currentVO", currentVO);
		resultMap.put("totalCount", totalCount);
		return resultMap;
	}
	
	/**
	 * 음성가이드 버전 리스트 조회(전체)
	 * 
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectAllVersionList(VoiceVO voiceVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> resultList = commonDao_oracle.selectList("Voice.selectAllVersionList",voiceVO);
		resultMap.put("resultList", resultList);
		return resultMap;
	}
	
	/**
	 * 음성가이드 버전 상세 조회
	 * 
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectVersionAjax(VoiceVO voiceVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		voiceVO = commonDao_oracle.select("Voice.selectVersionAjax",voiceVO);
		resultMap.put("voiceVO", voiceVO);
		return resultMap;
	}
	
	
	/**
	 * 음성가이드 등록
	 * 
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> addVersionAjax(VoiceVO voiceVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		voiceVO.setVoiceVerNo(UniqueKeyUtil.getUniKey());
		
		//해당 버전이 있는지 체크
		boolean exist = checkVersion(voiceVO);
		
		if(!exist){
			
			if(voiceVO.getUseYn().equals(Constants.YES)){
				//현재 사용중인 버전이 있는지 체크
				boolean duplicate = checkVersionUseYn(voiceVO);
				
				if(!duplicate){
					voiceVO.setVoiceVerNo(UniqueKeyUtil.getUniKey());
					commonDao_oracle.insert("Voice.insertVersion",voiceVO);
					resultMap.put(Constants.RESULT, Constants.YES);
					
					//Domain Copy Insert
					//기존 버전 조회
					List<VoiceVO> copyVersionList = commonDao_oracle.selectList("Voice.selectInsertCommandList",voiceVO);
					
					for(int idx=0; idx < copyVersionList.size(); idx++){
						VoiceVO tempVO = copyVersionList.get(idx);
						tempVO.setVoiceVerNo(voiceVO.getVoiceVerNo());
						tempVO.setVoiceGuideNo(UniqueKeyUtil.getUniKey());
						tempVO.setRegId(voiceVO.getRegId());
						tempVO.setUpdId(voiceVO.getUpdId());
						System.out.println("idx:"+ idx + " ## :" + tempVO.toString());
						commonDao_oracle.insert("Voice.insertCommand",tempVO);
					}
					
					
				}else{
					resultMap.put(Constants.RESULT, Constants.DUPLICATE);
				}
			}else{
				voiceVO.setVoiceVerNo(UniqueKeyUtil.getUniKey());
				commonDao_oracle.insert("Voice.insertVersion",voiceVO);
				resultMap.put(Constants.RESULT, Constants.YES);
				
				//Domain Copy Insert
				//기존 버전 조회
				List<VoiceVO> copyVersionList = commonDao_oracle.selectList("Voice.selectInsertCommandList",voiceVO);
				
				for(int idx=0; idx < copyVersionList.size(); idx++){
					VoiceVO tempVO = copyVersionList.get(idx);
					tempVO.setVoiceVerNo(voiceVO.getVoiceVerNo());
					tempVO.setVoiceGuideNo(UniqueKeyUtil.getUniKey());
					tempVO.setRegId(voiceVO.getRegId());
					tempVO.setUpdId(voiceVO.getUpdId());
					System.out.println("idx:"+ idx + " ## :" + tempVO.toString());
					commonDao_oracle.insert("Voice.insertCommand",tempVO);
				}
			}
			
			
		}else{
			resultMap.put(Constants.RESULT, Constants.EXIST);
		}
		return resultMap;
	}
	
	
	/**
	 * 음성가이드 버전 체크
	 * 
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	public boolean checkVersion(VoiceVO voiceVO){
		boolean result = false;
		int cnt = commonDao_oracle.select("Voice.checkVersion",voiceVO);
		
		if(cnt > 0){
			result = true;
		}
		return result;
	}
	
	/**
	 * 음성가이드 버전 사용 유무 체크
	 * 
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	public boolean checkVersionUseYn(VoiceVO voiceVO){
		boolean result = false;
		int cnt = commonDao_oracle.select("Voice.checkVersionUseYn",voiceVO);
		
		if(cnt > 0){
			result = true;
		}
		return result;
	}
	
	
	
	/**
	 * 음성가이드 버전 삭제
	 * 
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	
	public Map<String, Object> deleteVersionAjax(VoiceVO voiceVO)  throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int deleteCnt = commonDao_oracle.delete("Voice.deleteVersionAjax",voiceVO);
		
		if(deleteCnt > 0){
			resultMap.put("resultCode", ResultCode.RESULT_CODE_0000.getCode());
			
			//기존 버전 Command 삭제
			commonDao_oracle.delete("Voice.deleteDomainByVersionNo",voiceVO);
			
		}else{
			resultMap.put("resultCode", ResultCode.RESULT_CODE_4000.getCode());
		}
		
		return resultMap;
	}
	
	/**
	 * 음성가이드 버전 수정
	 * 
	 * @param termsVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> editVersionAjax(VoiceVO voiceVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if(voiceVO.getUseYn().equals(Constants.YES)){
			//현재 사용중인 버전이 있는지 체크
			boolean duplicate = checkVersionUseYn(voiceVO);
			
			//현재 사용중인 음성 가이드 버전 없음.
			if(!duplicate){
				if(commonDao_oracle.insert("Voice.updateVersion",voiceVO) > 0){
					resultMap.put(Constants.RESULT, Constants.YES);
				}else{
					resultMap.put(Constants.RESULT, Constants.NO);
				}	
			}else{
				resultMap.put(Constants.RESULT, Constants.DUPLICATE);
			}
		}else{
			commonDao_oracle.insert("Voice.updateVersion",voiceVO);
			resultMap.put(Constants.RESULT, Constants.YES);
		}
		return resultMap;
	}
	
	
	/**
	 * 음성가이드 명령어 리스트 조회
	 * 
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectCommandList(VoiceVO voiceVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> commandList = commonDao_oracle.selectList("Voice.selectCommandList",voiceVO);

		int totalCount = commonDao_oracle.select("Voice.selectCommandListCnt",voiceVO);

		//TB_VOICE_DOMAIN 조회
		List<Map<String, Object>> domainList = commonDao_oracle.selectList("Voice.selectAllDomainList",voiceVO);
		
		List<Map<String, Object>> guideVersionList = commonDao_oracle.selectList("Voice.selectAllVersionList",voiceVO);
		
		resultMap.put("guideVersionList", guideVersionList);
		resultMap.put("domainList", domainList);
		resultMap.put("commandList", commandList);
		resultMap.put("totalCount", totalCount);
		
		
		return resultMap;
	}
	
	
	/**
	 * 음성가이드 명령어 상세 조회
	 * 
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectCommandAjax(VoiceVO voiceVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		voiceVO = commonDao_oracle.select("Voice.selectCommand",voiceVO);
		resultMap.put("voiceVO", voiceVO);
		return resultMap;
	}
	

	/**
	 * 음성가이드 명령어 등록
	 * 
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> addCommandAjax(VoiceVO voiceVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		voiceVO.setVoiceGuideNo(UniqueKeyUtil.getUniKey());
		
		boolean duplicate = checkCommand(voiceVO);
		
		if(!duplicate){
			if(commonDao_oracle.insert("Voice.insertCommand",voiceVO) > 0){
				resultMap.put(Constants.RESULT, Constants.YES);
			}else{
				resultMap.put(Constants.RESULT, Constants.NO);
			}
		}else{
			resultMap.put(Constants.RESULT, Constants.DUPLICATE);
		}
		
		return resultMap;
	}
	
	
	/**
	 * 음성가이드 명령어 중복 체크
	 * 
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	public boolean checkCommand(VoiceVO voiceVO){
		boolean result = false;
		int cnt = commonDao_oracle.select("Voice.checkCommand",voiceVO);
		
		if(cnt > 0){
			result = true;
		}
		return result;
	}
	
	
	/**
	 * 음성가이드 명령어 수정
	 * 
	 * @param termsVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> editCommandAjax(VoiceVO voiceVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean duplicate = checkCommand(voiceVO);
		
		if(!duplicate){
			if(commonDao_oracle.insert("Voice.updateCommand",voiceVO) > 0){
				resultMap.put(Constants.RESULT, Constants.YES);
			}else{
				resultMap.put(Constants.RESULT, Constants.NO);
			}	
		}else{
			resultMap.put(Constants.RESULT, Constants.DUPLICATE);
		}
		return resultMap;
	}
	
	
	/**
	 * 음성가이드 명령어 삭제
	 * 
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	
	public Map<String, Object> deleteCommandAjax(VoiceVO voiceVO)  throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int deleteCnt = commonDao_oracle.delete("Voice.deleteCommand",voiceVO);
		
		if(deleteCnt > 0){
			resultMap.put("resultCode", ResultCode.RESULT_CODE_0000.getCode());
		}else{
			resultMap.put("resultCode", ResultCode.RESULT_CODE_4000.getCode());
		}
		
		return resultMap;
	}
	
	
	/**
	 * 음성가이드 명령어 선택 수정
	 * 
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	
	public Map<String, Object> selectCommandModi(VoiceVO voiceVO)  throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		//voiceGuideNoArray
		//prioSeqArray
		//exposureSeqArray
		if(voiceVO.getPrioSeqArray().length == 0 && voiceVO.getExposureSeqArray().length == 0){
			//모두 체크 풀기.
			commonDao_oracle.update("Voice.allUnCheck",voiceVO);
			
			resultMap.put("resultCode", ResultCode.RESULT_CODE_0000.getCode());
		}else{
			
			//우선순위 업데이트
			for(int idx=0; idx < voiceVO.getVoiceGuideNoArray().length; idx++ ){
				String voiceGuideNo = voiceVO.getVoiceGuideNoArray()[idx];  
				//getVoiceGuideNoArray
				if(Arrays.asList(voiceVO.getPrioSeqArray()).contains(voiceGuideNo)){
					commonDao_oracle.update("Voice.updateCammanPrioY",voiceGuideNo);
					
				}else{
					commonDao_oracle.update("Voice.updateCammanPrioN",voiceGuideNo);
					
				}
			}
			
			//노출 여부 업데이트
			for(int idx=0; idx < voiceVO.getVoiceGuideNoArray().length; idx++ ){
				String voiceGuideNo = voiceVO.getVoiceGuideNoArray()[idx];
					commonDao_oracle.update("Voice.updateCammanExposureY",voiceGuideNo);
				if(Arrays.asList(voiceVO.getExposureSeqArray()).contains(voiceGuideNo)){
					
				}else{
					commonDao_oracle.update("Voice.updateCammanExposureN",voiceGuideNo);
				
				}
			}
			resultMap.put("resultCode", ResultCode.RESULT_CODE_0000.getCode());
		}
		return resultMap;
		
	}
	
}
