package com.lgu.ccss.admin.voice.service;

import java.util.Map;

import com.lgu.ccss.admin.term.domain.TermsVO;
import com.lgu.ccss.admin.voice.domain.VoiceVO;





public interface VoiceService {
	
	//도메인
	public Map<String, Object> selectDomainList(VoiceVO voiceVO) throws Exception ;
	
	public Map<String, Object> selectAllDomainList(VoiceVO voiceVO)  throws Exception; 

	public Map<String, Object> addDomainAjax(VoiceVO voiceVO) throws Exception;
	
	public Map<String, Object> selectDomainAjax(VoiceVO voiceVO) throws Exception;
	
	public Map<String, Object> editDomainAjax(VoiceVO voiceVO) throws Exception;
	
	public Map<String, Object> deleteDomainAjax(VoiceVO voiceVO)  throws Exception;
	
	//버전
	public Map<String, Object> selectVersionList(VoiceVO voiceVO) throws Exception ;

	public Map<String, Object> addVersionAjax(VoiceVO voiceVO) throws Exception;
	
	public Map<String, Object> selectVersionAjax(VoiceVO voiceVO) throws Exception;
	
	public Map<String, Object> editVersionAjax(VoiceVO voiceVO) throws Exception;
	
	public Map<String, Object> deleteVersionAjax(VoiceVO voiceVO)  throws Exception;
	
	public Map<String, Object> selectAllVersionList(VoiceVO voiceVO)  throws Exception; 
	//커멘드
	public Map<String, Object> selectCommandList(VoiceVO voiceVO) throws Exception ;

	public Map<String, Object> addCommandAjax(VoiceVO voiceVO) throws Exception;
	
	public Map<String, Object> selectCommandAjax(VoiceVO voiceVO) throws Exception;
	
	public Map<String, Object> editCommandAjax(VoiceVO voiceVO) throws Exception;
	
	public Map<String, Object> deleteCommandAjax(VoiceVO voiceVO)  throws Exception;
	
	public Map<String, Object> selectCommandModi(VoiceVO voiceVO)  throws Exception;
	
	
}
